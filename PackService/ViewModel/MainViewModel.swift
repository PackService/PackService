//
//  MainViewModel.swift
//  PackService
//
//  Created by 박윤환 on 2023/02/01.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {

    @Published var isLoading: Bool = true
    @Published var info: TrackInfo? //파베에서 받는 데이터
    @Published var company: String = ""
    @Published var searchText = ""
    
    var service: EmailService
    private var trackingInfoService = TrackingInfoService()
    private var companyService = CompanyService()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var trackingModels: [InfoModel] = []
    @Published var carouselItems: [InfoModel] = []
    @Published var searchModels: [InfoModel] = []
    @Published var sortedTrackingModels: [InfoModel] = []
    @Published var total: Int = 0
    @Published var totalCompany: Int = 0
    @Published var completed: Int = 0
    @Published var companyCount: [String: Int] = [:]
    @Published var mostUsed: String = ""
    @Published var historyItem: String = ""
    
    init(service: EmailService) {
        self.service = service
//        print("패키지 순서: \(self.service.pack[0])")
//        service.readTrackNumber()
//        self.emailService = emailService
//        self.info = emailService.trackInfo
//        setup(emailService: emailService)
        addSubscribers()
//        print("trackingModels: \(self.trackingModels)")
    }
    
    
    // 1. MainView에 표시할 정보들을 TrackInfoModel에서 추출해서 다른 모델에 저장해야함 (完)
    // => Optional 처리에 의한 번거로움을 줄이기 위해서
    // 2. 만약 Firebase에서 데이터를 받아오는 순서가 운송장 번호가 등록된 순서와 다르다면
    // => Firebase의 userTrackInfo 필드에 index/id/timestamp 속성을 추가한 후, sort하여 사용해야 함
    // 3. 운송장 추가 화면에서 회사 선택 시 텍스트 필드에는 회사 이름이, Firebase에는 회사 코드가 저장되도록 수정해야함 (完)
    // 4. reload 함수를 구현해서 화면이 바뀔때마다 데이터를 업데이트해야함
    // 5. 로그인 후 로그인 정보가 앱을 종료하고 다시 실행했을 때 남아 있어야함
    
    func addSubscribers() {        
        guard let info = self.service.trackInfo else {
            return
        }
//        print(info.userTracksInfo![0])
//        print("info!! : \(info)") // 여기까지는 순서 잘 들어감
        companyService.$allCompanies
            .sink { [weak self] (companyModel) in
                self?.totalCompany = companyModel.company.count
            }
            .store(in: &cancellables)
        
        trackingInfoService.getTrackingInfos(info: info) // 여기서 가져오는 순서 때문에 뒤바뀜
        trackingInfoService.$infos
            .map(mapToInfoModels)
            .sink { [weak self] (models) in
                self?.total = models.count
//                self?.totalCompany = self?.companyService.allCompanies.company.count ?? 0
                self?.completed = models.filter { $0.isComplete }.count
                let mostUsedCompany = self?.companyCount.max(by: { $0.value < $1.value })?.key ?? "정보없음"
                self?.mostUsed = self?.companyService.allCompanies.company.first(where: { $0.id == mostUsedCompany})?.name ?? ""
                
                self?.historyItem = models.first(where: {
                    $0.company == self?.service.trackInfo?.history[0] &&
                    $0.invoice == self?.service.trackInfo?.history[1]
                })?.name ?? "최근 사용한 기록이 없습니다"
                self?.trackingModels = models
                self?.isLoading = false
            }
            .store(in: &cancellables)
        
        getCarouselItems()

        $searchText
            .combineLatest($trackingModels)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filtering)
            .sink { [weak self] (models) in
                self?.searchModels = models
            }
            .store(in: &cancellables)
    }

    // 파베에 변수 추가
    // 
    func mapToInfoModels(infos: [TrackingInfoModel]) -> [InfoModel] {
        self.companyCount = [:]
        var sortedInfos = infos.sorted(by: { $0.addedTime! < $1.addedTime! })
        var models = [InfoModel]()
        for info in sortedInfos {
            if let company = info.company {
                self.companyCount[company] = (self.companyCount[company] ?? 0) + 1
            }
            var model = InfoModel(
                isComplete: info.complete ?? false,
                company: info.company?.mapInfo("정보없음") ?? "정보없음",
                invoice: info.invoiceNo?.mapInfo("정보없음") ?? "정보없음",
                name: info.itemName?.mapInfo((info.invoiceNo ?? "") + " 물품") ?? (info.invoiceNo ?? "") + " 물품",
                currentStep: info.currentStep,
                itemWhere: info.trackingDetails?.last?.detailWhere.mapInfo("정보없음") ?? "정보없음",
                time: info.trackingDetails?.last?.timeAndDateTuple.time.mapInfo("정보없음") ?? "정보없음"
            )
//            print("mapToInfoModels: \(model.company)")
            models.append(model)
        }
        print("MOST USED" , companyCount)
        return models
    }
    
    func reloadData() {
        
    }
    
    private func filtering(text: String, models: [InfoModel]) -> [InfoModel] {
        guard !text.isEmpty else { return models }
        
        let lowercasedText = text.lowercased()
        
        return models.filter { model in
            return model.invoice.lowercased().contains(lowercasedText) ||
            model.name.lowercased().contains(lowercasedText)
        }
    }
    
//    func mapCompanyToTrackingInfo(info: TrackingInfoModel?, company: String) -> TrackingInfoModel? {
//        if let info = info {
//            let newTrackingInfo = TrackingInfoModel(complete: info.complete, level: info.level, invoiceNo: info.invoiceNo, isValidInvoice: info.isValidInvoice, itemImage: info.itemImage, itemName: info.itemName, receiverAddr: info.receiverAddr, receiverName: info.receiverName, recipient: info.recipient, senderName: info.senderName, trackingDetails: info.trackingDetails, estimate: info.estimate, productInfo: info.productInfo, company: company, status: info.status, msg: info.msg, code: info.code)
//
//            return newTrackingInfo
//        }
//
//        return nil
//    }
    
    func getCarouselItems() {
        $trackingModels
            .sink { [weak self] (models) in
                self?.carouselItems = []
                if models.count >= 3 {
                    self?.carouselItems = Array(models.suffix(3)).reversed()
                } else {
                    self?.carouselItems = Array(models.suffix(3)).reversed()
                    self?.carouselItems.append(InfoModel(isComplete: false, company: "", invoice: "", name: "", currentStep: 0, itemWhere: "", time: ""))
                }
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }

}

//
//        trackingInfoService.$trackingInfo
////            .combineLatest($company)
////            .map(mapCompanyToTrackingInfo)
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] (model) in
//                guard let model = model else { return }
//
//                self?.trackingModels.append(model)
//                print(self?.trackingModels)
//            }
//            .store(in: &cancellables)
//
        
        

//    func fetchData(info: TrackInfo) -> [TrackingInfoModel] {
//        guard let trackInfos = info.userTracksInfo else {
//            print("trackinfo")
//            return []
//        }
//
//        var result = [TrackingInfoModel]()
//
//        for trackInfo in trackInfos {
//            trackingInfoService.getTrackingInfo(trackInfo.trackCompany, trackInfo.trackNumber)
//
//            result.append(trackingInfoService.trackingInfo ?? TrackingInfoModel(complete: nil, level: -1, invoiceNo: nil, isValidInvoice: nil, itemImage: nil, itemName: nil, receiverAddr: nil, receiverName: nil, recipient: nil, senderName: nil, trackingDetails: nil, estimate: nil, productInfo: nil, status: nil, msg: nil, code: nil))
//        }
//
//        return result
//    }


//        guard let info = info else {
//            print("info")
//            return
//        }
//        guard let trackInfos = info.userTracksInfo else {
//            print("trackinfo")
//            return
//        }
//
//        $trackingInfoService
//            .combineLatest($info)
//            .map(generateServices)
//            .sink { [weak self] (models) in
//                self?.trackingModels = models
//            }
//            .store(in: &cancellables)
        
//        for info in trackInfos {
//            print(info.trackNumber)
//            print(info.trackCompany)
//            let service = TrackingInfoService(code: info.trackCompany, invoice: info.trackNumber)
//
//            service.getTrackingInfo(info.trackCompany, info.trackNumber)
//            service.$trackingInfo
//                .sink { [weak self] (model) in
//                    guard let track = model else {
//                        print("model fetch fail")
//                        return
//                    }
//                    self?.trackingModels.append(track)
//                }
//                .store(in: &self.cancellables)
//        }
