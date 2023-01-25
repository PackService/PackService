//
//  TrackingInfoViewModel.swift
//  PackService
//
//  Created by 박윤환 on 2023/01/17.
//

import Foundation
import Combine

class TrackingInfoViewModel: ObservableObject {
    
    @Published var code: String
    @Published var invoice: String
    private var companyService: CompanyService
    private var trackingInfoService: TrackingInfoService
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var isComplete: Bool = false
    @Published var name: String?
    @Published var item: String = ""
    @Published var receiver: String = ""
    @Published var sender: String = ""
    @Published var deliveryMan: String = ""
    @Published var deliveryManContact: String = ""
    @Published var estimate: String?
    @Published var positions: [String?] = []
    @Published var trackingDetails: [TrackingDetailsModel] = []
    
    @Published var showAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
   
    init(code: String, invoice: String) {
        self.code = code
        self.invoice = invoice
        self.companyService = CompanyService()
        self.trackingInfoService = TrackingInfoService(code: code, invoice: invoice)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        companyService.$allCompanies
            .sink { [weak self] (companyModel) in
                if let company = companyModel.company.first(where: { company in
                    company.id == self?.code
                }) {
                    self?.name = company.name
                } else {
                    self?.name = "택배사 이름"
                }
            }
            .store(in: &cancellables)
        
        trackingInfoService.$trackingInfo
            .sink { [weak self] (trackingInfoModel) in
                guard let trackingDetailModel = trackingInfoModel else { return }
                if let status = trackingDetailModel.status,
                   let code = trackingDetailModel.code,
                   let msg = trackingDetailModel.msg {
                    self?.showAlert = true
                    self?.alertTitle = code
                    self?.alertMessage = msg
                } else {
                    self?.isComplete = trackingDetailModel.complete ?? false
                    self?.item = trackingDetailModel.itemName ?? ""
                    self?.receiver = trackingDetailModel.receiverName ?? ""
                    self?.sender = trackingDetailModel.senderName ?? ""
                    self?.trackingDetails = trackingDetailModel.trackingDetails ?? []
                    self?.estimate = trackingDetailModel.estimate
                    self?.positions = trackingDetailModel.positionArray
                    
                    if let trackingDetails = trackingDetailModel.trackingDetails?.first(where: { trackingDetail in
                        trackingDetail.level >= 5
                    }) {

                        self?.deliveryMan = trackingDetails.manName
    //                    debugPrint(self?.deliveryMan)
                        self?.deliveryManContact = trackingDetails.telno2
                    } else {
                        self?.deliveryMan = ""
                        self?.deliveryManContact = ""
                    }
                }
                
            }
            .store(in: &cancellables)
    }
}