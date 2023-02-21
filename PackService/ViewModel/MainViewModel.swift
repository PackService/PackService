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
    @Published var userInfo: UserInfo? //파베에서 받는 데이터
    @Published var company: String = ""
    @Published var searchText = ""
    
    @Published var trackingModels: [ShowModel] = []
    @Published var carouselItems: [ShowModel] = []
    @Published var searchModels: [ShowModel] = []
    @Published var sortedTrackingModels: [ShowModel] = []
    @Published var total: Int = 0
    @Published var totalCompany: Int = 0
    @Published var completed: Int = 0
    @Published var companyCount: [String: Int] = [:]
    @Published var mostUsed: String = ""
    @Published var historyItem: String = ""
    @Published var historyCompany: String?
    @Published var historyInvoice: String?
    
    var service: LoginService
    private var trackingInfoService = TrackingInfoService()
    private var companyService = CompanyService()
    private var cancellables = Set<AnyCancellable>()
    
    init(service: LoginService) {
        self.service = service
        addSubscribers()
    }
    
    func addSubscribers() {        
        guard let info = self.service.userInfo else {
            return
        }
        
        companyService.$allCompanies
            .sink { [weak self] (companyModel) in
                self?.totalCompany = companyModel.company.count
            }
            .store(in: &cancellables)
        
        trackingInfoService.getTrackingInfos(userInfo: info) // 여기서 가져오는 순서 때문에 뒤바뀜
        trackingInfoService.$infos
            .map(mapToInfoModels)
            .sink { [weak self] (models) in
                self?.total = models.count
                self?.completed = models.filter { $0.isComplete }.count
                
                let mostUsedCompany = self?.companyCount.max(by: { $0.value < $1.value })?.key ?? "정보없음"
                self?.mostUsed = self?.companyService.allCompanies.company.first(where: { $0.id == mostUsedCompany})?.name ?? ""
                
                if !(self?.service.userInfo?.history.isEmpty ?? true) {
                    self?.historyItem = models.first(where: {
                        $0.company == self?.service.userInfo?.history[0] &&
                        $0.invoice == self?.service.userInfo?.history[1]
                    })?.name ?? "정보없음"
                    self?.historyCompany = self?.service.userInfo?.history[0]
                    self?.historyInvoice = self?.service.userInfo?.history[1]
                } else {
                    self?.historyItem = "최근 사용한 기록이 없습니다"
                }
                
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

    func mapToInfoModels(infos: [TrackingInfoModel]) -> [ShowModel] {
        self.companyCount = [:]
        
        var sortedInfos = infos.sorted(by: { $0.addedTime! < $1.addedTime! })
        var models = [ShowModel]()
        
        for info in sortedInfos {
            if let company = info.company {
                self.companyCount[company] = (self.companyCount[company] ?? 0) + 1
            }
            
            var model = ShowModel(
                isComplete: info.complete ?? false,
                company: info.company?.mapInfo("정보없음") ?? "정보없음",
                invoice: info.invoiceNo?.mapInfo("정보없음") ?? "정보없음",
                name: info.itemName?.mapInfo((info.invoiceNo ?? "") + " 물품") ?? (info.invoiceNo ?? "") + " 물품",
                currentStep: info.currentStep,
                itemWhere: info.trackingDetails?.last?.detailWhere.mapInfo("정보없음") ?? "정보없음",
                time: info.trackingDetails?.last?.timeAndDateTuple.time.mapInfo("정보없음") ?? "정보없음"
            )
            
            models.append(model)
        }
        print("MOST USED" , companyCount)
        return models
    }
    
    private func filtering(text: String, models: [ShowModel]) -> [ShowModel] {
        guard !text.isEmpty else { return models }
        
        let lowercasedText = text.lowercased()
        
        return models.filter { model in
            return model.invoice.lowercased().contains(lowercasedText) ||
            model.name.lowercased().contains(lowercasedText)
        }
    }
    
    func getCarouselItems() {
        $trackingModels
            .sink { [weak self] (models) in
                self?.carouselItems = []
                if models.count >= 3 {
                    self?.carouselItems = Array(models.suffix(3)).reversed()
                } else {
                    self?.carouselItems = Array(models.suffix(3)).reversed()
                    self?.carouselItems.append(ShowModel(isComplete: false, company: "", invoice: "", name: "", currentStep: 0, itemWhere: "", time: ""))
                }
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }

}
