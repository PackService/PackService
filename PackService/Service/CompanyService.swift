//
//  CompanyService.swift
//  PackService
//
//  Created by 박윤환 on 2022/12/21.
//

import Foundation
import Combine

class CompanyService: ObservableObject {
    
    @Published var allCompanies: CompanyModel = CompanyModel(company: [])
    
    var companySubscription: AnyCancellable?
    
    init() {
        getCompanies()
    }
    
    func getCompanies() {
        guard let url = URL(string: "https://info.sweettracker.co.kr/api/v1/companylist?t_key=R3piwpbvEXgOCxQFddJEgw") else { return }
        
        companySubscription = NetworkingManager.download(url: url)
            .decode(type: CompanyModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCompanies) in
                self?.allCompanies = returnedCompanies
                self?.companySubscription?.cancel()
            })
    }
}
