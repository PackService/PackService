//
//  TrackingInfoService.swift
//  PackService
//
//  Created by 박윤환 on 2022/12/21.
//

import Foundation
import Combine

//    TrackingInfoModel(
//        complete: false,
//        level: 0,
//        invoiceNo: "",
//        isValidInvoice: "",
//        itemImage: "", itemName: "",
//        receiverAddr: "", receiverName: "", recipient: "",
//        senderName: "",
//        trackingDetails: [],
//        estimate: "",
//        productInfo: "")

class TrackingInfoService: ObservableObject {
    
    @Published var trackingInfo: TrackingInfoModel? = nil
    @Published var infos: [TrackingInfoModel] = []
    
    var trackingInfoSubscription: AnyCancellable?
    var infosSubscription = Set<AnyCancellable>()

    init(code: String = "", invoice: String = "") {
        getTrackingInfo(code, invoice)
    }
    
    func getTrackingInfo(_ code: String, _ invoice: String) {
        
        guard let url = URL(string: "https://info.sweettracker.co.kr/api/v1/trackingInfo?t_code=\(code)&t_invoice=\(invoice)&t_key=1DsMXGyjhh0tW8MAmxC1gw") else {
            print("url error")
            return }
        Task {
           await trackingInfoSubscription = NetworkingManager.download(url: url)
                .decode(type: TrackingInfoModel.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedTrackingInfo) in
                    self?.trackingInfo = returnedTrackingInfo
                    self?.trackingInfo?.company = code
                    print(returnedTrackingInfo)
                    self?.trackingInfoSubscription?.cancel()
                })
        }
    }
    
    func getTrackingInfos(info: TrackInfo) {
        guard let infos = info.userTracksInfo else {
            print("FAILED TO GET INFOS")
            return
        }
        // 대한 한진 롯데 우체국
        for info in infos {
//            print("PACKAGE INFOS", info)
            
            guard let url = URL(string: "https://info.sweettracker.co.kr/api/v1/trackingInfo?t_code=\(info.trackCompany)&t_invoice=\(info.trackNumber)&t_key=1DsMXGyjhh0tW8MAmxC1gw") else {
                print("url error")
                return }
            print("info.trackCompany: \(info.trackCompany)")
            print("info.trackNumber: \(info.trackNumber)")
            
            NetworkingManager.download(url: url) //download를 async로??
                .decode(type: TrackingInfoModel.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedTrackingInfo) in
                    var newTrackingInfo = returnedTrackingInfo
                    newTrackingInfo.company = info.trackCompany
                    newTrackingInfo.addedTime = info.timeStamp
                    newTrackingInfo.invoiceNo = info.trackNumber
//                    returnedTrackingInfo.company = info.trackCompany
                    self?.infos.append(newTrackingInfo)
                    print("newtrackingInfo : \(newTrackingInfo)")
//                    print("RESULT:", self?.infos)
//                    self?.infosSubscription?.cancel()
                })
                .store(in: &infosSubscription)
        }
    }
}
