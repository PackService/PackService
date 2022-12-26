//
//  RecommendService.swift
//  PackService
//
//  Created by 이범준 on 12/26/22.
//

import Foundation
import Combine

class RecommendService: ObservableObject {
    @Published var allRecommend: RecommendModel = RecommendModel(recommend: [])
    var recommendSubscription: AnyCancellable?
    
    init() {
        recommendCompanies()
    }
    
    func recommendCompanies() {
        guard let url = URL(string: "https://info.sweettracker.co.kr/api/v1/recommend?t_invoice=364097746100&t_key=eVPJb8troT0cn5eY15H6yw") else { return }
        
        recommendSubscription = NetworkingManager.download(url: url)
            .decode(type: RecommendModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedRecommends) in
                self?.allRecommend = returnedRecommends
                print(self?.allRecommend)
                self?.recommendSubscription?.cancel()
            })
    }
}
