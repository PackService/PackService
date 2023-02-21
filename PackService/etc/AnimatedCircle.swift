//
//  AnimatedCircle.swift
//  PackService
//
//  Created by 박윤환 on 2022/12/28.
//

import SwiftUI

struct AnimatedCircle: View {
    
    @State var isAnimated: Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(ColorManager.background2)
                .shadow(color: Color.black.opacity(0.05), radius: 20, x: 0, y: 2)
            
            HStack {
                VStack(spacing: 8) { // 인사이트 정보
                    HStack {
                        Text("최근 사용된 운송장")
                            .font(FontManager.caption1)
                            .foregroundColor(ColorManager.foreground1)
                        Spacer()
                    }
                    
                    HStack {
                        Text("1일 3시간 32분")
                            .font(FontManager.body1)
                        Spacer()
                    }
                                       
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "arrow.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .font(FontManager.body1)
                        .foregroundColor(ColorManager.background)
                        .padding(8)
                        .background(Circle().fill(ColorManager.primaryColor))
                }
            }
            .padding(.horizontal, 20)
        }
        .frame(height: 88)
    }
}

struct AnimatedCircle_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedCircle()
    }
}
