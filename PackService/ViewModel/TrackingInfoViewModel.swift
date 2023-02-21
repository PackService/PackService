//
//  TrackingInfoViewModel.swift
//  PackService
//
//  Created by 박윤환 on 2023/01/17.
//

import Foundation
import Combine

class TrackingInfoViewModel: ObservableObject {
    
    @Published var company: String
    @Published var invoice: String
    @Published var isLoading: Bool = true
    
    @Published var isComplete: Bool = false
    @Published var companyName: String?
    @Published var item: String = ""
    @Published var receiver: String = ""
    @Published var sender: String = ""
    @Published var deliveryMan: String = ""
    @Published var deliveryManContact: String = ""
    @Published var estimate: String?
    @Published var currentStep: Double = 0.0
    @Published var trackingDetails: [TrackingDetailsModel] = []
    
    @Published var showAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    
    private var companyService: CompanyService
    private var trackingInfoService: TrackingInfoService {
        didSet {
            addSubscribers()
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    init(company: String, invoice: String) {
        self.company = company
        self.invoice = invoice
        self.companyService = CompanyService()
        self.trackingInfoService = TrackingInfoService(company: company, invoice: invoice)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        companyService.$allCompanies
            .sink { [weak self] (companyModel) in
                if let company = companyModel.company.first(where: { company in
                    company.id == self?.company
                }) {
                    self?.companyName = company.name
                } else {
                    self?.companyName = "택배사 이름"
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
                    self?.currentStep = trackingDetailModel.currentStep
                    
                    if let trackingDetails = trackingDetailModel.trackingDetails?.first(where: { trackingDetail in
                        trackingDetail.level >= 5
                    }) {

                        self?.deliveryMan = trackingDetails.manName
                        self?.deliveryManContact = trackingDetails.telno2
                    } else {
                        self?.deliveryMan = ""
                        self?.deliveryManContact = ""
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func reloadData(company: String, invoice: String) {
        isLoading = true
        currentStep = 0.0
        trackingInfoService.getTrackingInfo(company, invoice)
    }
    
    func getTrackingInfoService(company: String, invoice: String) {
        self.trackingInfoService = TrackingInfoService(company: company, invoice: invoice)
    }
}
