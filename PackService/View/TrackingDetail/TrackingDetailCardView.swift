//
//  TrackingDetailCardView.swift
//  PackService
//
//  Created by 박윤환 on 2023/01/16.
//

import SwiftUI

struct TrackingDetailCardView: View {
    var title: String
    var content: String?
    var deliveryman: Bool = false
    @Binding var show: Bool?
    
    init(title: String, content: String? = nil, deliveryman: Bool = false, show: Binding<Bool?> = .constant(nil)) {
        self.title = title
        self.content = content
        self.deliveryman = deliveryman
        self._show = show
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .fill(ColorManager.background2)
                .frame(width: 170, height: 88)
                            
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(FontManager.caption2)
                    .foregroundColor(ColorManager.foreground1)
                
                HStack {
                    Text(content ?? "정보 없음")
                        .font(FontManager.body1)
                        .foregroundColor(content != nil ? .black : ColorManager.foreground2)
                    
                    if deliveryman {
                        Button {
                            withAnimation(Animation.easeIn(duration: 0.2)) {
                                show?.toggle()
                            }
                            
                        } label: {
                            
                            Image(systemName: "phone.circle.fill")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(ColorManager.primaryColor)

                        }
                    }
                }
                
            }
            .padding(.leading, 20)
        }
    }
}

struct TrackingDetailCardView_Previews: PreviewProvider {
    static var previews: some View {
        TrackingDetailCardView(title: "받는 분", content: "홍길동", deliveryman: true)
    }
}
