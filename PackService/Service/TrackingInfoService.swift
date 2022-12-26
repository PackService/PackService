//
//  TrackingInfoService.swift
//  PackService
//
//  Created by 박윤환 on 2022/12/21.
//

import Foundation
import Combine

class TrackingInfoService {
    
    @Published var trackingInfo: TrackingInfoModel = TrackingInfoModel(
        complete: false,
        level: 0,
        invoiceNo: "",
        isValidInvoice: "",
        itemImage: "", itemName: "",
        receiverAddr: "", receiverName: "", recipient: "",
        senderName: "",
        trackingDetails: [],
        estimate: "",
        productInfo: "")
    
    var trackingInfoSubscription: AnyCancellable?
    
    init(_ code: String, _ invoice: String) {
        getTrackingInfo(code, invoice)
    }
    
    func getTrackingInfo(_ code: String, _ invoice: String) {
        guard let url = URL(string: "https://info.sweettracker.co.kr/api/v1/companylist?t_code=\(code)&t_invoice=\(invoice)&t_key=eVPJb8troT0cn5eY15H6yw") else { return }
        
        trackingInfoSubscription = NetworkingManager.download(url: url)
            .decode(type: TrackingInfoModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedTrackingInfo) in
                self?.trackingInfo = returnedTrackingInfo
                self?.trackingInfoSubscription?.cancel()
            })
        
    }
}
