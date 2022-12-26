//
//  RecommendTrackView.swift
//  PackService
//
//  Created by 이범준 on 12/26/22.
//

import SwiftUI

struct RecommendTrackView: View {
    @StateObject var recommendVM = RecommendService()
    @StateObject var companyVM = CompanyService()
    
    @State var trackingNumber = ""
    

    var body: some View {
        VStack(spacing: 20) {
        
            Button {
                print(recommendVM.allRecommend.recommend)
                print(companyVM.allCompanies.company)
//                print(recommendVM.allCompanies.company)
            } label: {
                
                Text("운송장 조회")
                    .foregroundColor(.white)
                    .padding(.vertical, 12)
                    .frame(width: UIScreen.main.bounds.width / 2)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Spacer()
        }
        
        Spacer()
        
    }
}
struct RecommendTrackView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendTrackView()
    }
}
