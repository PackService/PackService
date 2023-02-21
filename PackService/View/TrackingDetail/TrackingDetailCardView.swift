//
//  TrackingDetailCardView.swift
//  PackService
//
//  Created by 박윤환 on 2023/01/16.
//

import SwiftUI

struct TrackingDetailCardView: View {
    var title: String
    var content: String = ""
    var deliveryman: Bool = false
    var isComplete: Bool = false
    @Binding var show: Bool?
    
    //MARK: - Initializer
    init(title: String, content: String = "", deliveryman: Bool = false, show: Binding<Bool?> = .constant(nil), isComplete: Bool = false) {
        self.title = title
        self.content = content
        self.deliveryman = deliveryman
        self._show = show
        self.isComplete = isComplete
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            //background
            background
                            
            //foreground
            VStack(alignment: .leading, spacing: 8) {
                //title
                titleView
                
                //content
                contentView
                
            }
            .padding(.leading, 20)
        }
    }
}

extension TrackingDetailCardView {
    //MARK: - Background
    var background: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(ColorManager.background2)
            .frame(width: 170, height: 88)
            .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 2)
    }
    
    //MARK: - Title
    var titleView: some View {
        Text(title)
            .font(FontManager.caption2)
            .foregroundColor(ColorManager.foreground1)
    }
    
    //MARK: - Content
    var contentView: some View {
        HStack {
            Text(!isComplete ? (!content.isEmpty ? content : "정보 없음") : "배송 완료")
                .font(FontManager.body1)
                .foregroundColor(!isComplete ? (!content.isEmpty ? .black : ColorManager.foreground2) : ColorManager.primaryColor)
            
            if deliveryman && !content.isEmpty {
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
}

struct TrackingDetailCardView_Previews: PreviewProvider {
    static var previews: some View {
        TrackingDetailCardView(title: "받는 분", content: "홍길동", deliveryman: true)
    }
}
