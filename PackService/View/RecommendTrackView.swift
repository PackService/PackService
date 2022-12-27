//
//  RecommendTrackView.swift
//  PackService
//
//  Created by 이범준 on 12/26/22.
//

import SwiftUI

struct RecommendTrackView: View {
    @StateObject var recommendVM = RecommendService("")
    
    @State var trackingNumber = ""
    @State var selectedCompany = Recommend(id: "", international: "", name: "")

    var body: some View {
        VStack(spacing: 20) {
            Form {
                TextField("운송장 번호 입력", text: $trackingNumber)
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
                    .onChange(of: trackingNumber) { _ in
                        recommendVM.getRecommendCompanies(trackingNumber)
                    }
                
                Picker(selection: $selectedCompany, label: Text("택배사 선택")) {
                    ForEach(recommendVM.allRecommend.recommend) { company in
                        Text(company.name).tag(company)
                    }
                }
                .pickerStyle(.navigationLink)

            }
            .frame(maxHeight: 200)
            
            VStack(alignment: .leading, spacing: 20) {
                Text("운송장 번호: \(trackingNumber)")
            }
            Button {
                print(recommendVM.allRecommend.recommend)
                recommendVM.getRecommendCompanies(trackingNumber)
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
