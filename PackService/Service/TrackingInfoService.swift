//
//  TrackingInfoService.swift
//  PackService
//
//  Created by 박윤환 on 2022/12/21.
//

import Foundation
import Combine

class TrackingInfoService: ObservableObject {
    
    @Published var trackingInfo: TrackingInfoModel? = nil
    @Published var infos: [TrackingInfoModel] = []
    @Published var errorMessage: String = " "
    @Published var showAlert = false
    
    var trackingInfoSubscription: AnyCancellable?
    var infosSubscription = Set<AnyCancellable>()

    init(company: String = "", invoice: String = "") {
        getTrackingInfo(company, invoice)
    }
    
    func getTrackingInfo(_ company: String, _ invoice: String) {
        
        guard let url = URL(string: "https://info.sweettracker.co.kr/api/v1/trackingInfo?t_code=\(company)&t_invoice=\(invoice)&t_key=2WazFDmHoOWTz1wcpN2VeA") else {
            print("url error")
            return }
        trackingInfoSubscription = NetworkingManager.download(url: url)
            .decode(type: TrackingInfoModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedTrackingInfo) in
                self?.trackingInfo = returnedTrackingInfo
                self?.trackingInfo?.company = company
                if invoice != "" {
                    self?.errorMessage = returnedTrackingInfo.msg ?? ""
                }
                print("getTracking info error Message: \(self?.errorMessage)")
                print("getTrackingInfo: \(returnedTrackingInfo)")
                self?.trackingInfoSubscription?.cancel()
            })
    }
    
    func getTrackingInfos(userInfo: UserInfo) {
        guard let infos = userInfo.trackInfos else {
            print("FAILED TO GET INFOS")
            return
        }
        
        for info in infos {
            guard let url = URL(string: "https://info.sweettracker.co.kr/api/v1/trackingInfo?t_code=\(info.company)&t_invoice=\(info.invoice)&t_key=2WazFDmHoOWTz1wcpN2VeA") else {
                print("url error")
                return }
            print("info.company: \(info.company)")
            print("info.trackNumber: \(info.invoice)")
            
            NetworkingManager.download(url: url) //download를 async로??
                .decode(type: TrackingInfoModel.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedTrackingInfo) in
                    var newTrackingInfo = returnedTrackingInfo
                    newTrackingInfo.company = info.company
                    newTrackingInfo.addedTime = info.timeStamp
                    newTrackingInfo.invoiceNo = info.invoice
                    self?.infos.append(newTrackingInfo)
                    print("newtrackingInfo : \(newTrackingInfo)")
                })
                .store(in: &infosSubscription)
        }
    }
}
