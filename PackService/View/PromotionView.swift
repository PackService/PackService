//
//  PromotionView.swift
//  PackService
//
//  Created by 이범준 on 1/8/23.
//

import SwiftUI

// MARK: - 광고를 위한 PromotionView
struct PromotionView: View {// 글씨체 수정해야 함
    var promotionTitle: String
    var promotionImage: Image?
    var promotionContent: String
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text(promotionTitle)
                        .font(FontManager.caption2)
                    Text(promotionContent)
                        .font(FontManager.caption1)
                }
                .padding(.leading, 20)
                Spacer()
                Image(systemName: "rectangle")
                    .resizable()
                    .frame(width:80, height: 50)
                    .padding(.trailing, 16)
            }
            .padding(.top, 12)
            .padding(.bottom, 12)
        }
        .background(ColorManager.background2)
        .cornerRadius(10)
        .frame(height: 74)
    }
}

struct PromotionView_Previews: PreviewProvider {
    static var previews: some View {
        PromotionView(promotionTitle: "제목", promotionContent: "내용")
    }
}
