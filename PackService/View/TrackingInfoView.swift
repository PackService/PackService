//
//  TrackingInfoView.swift
//  PackService
//
//  Created by 박윤환 on 2022/12/26.
//

import SwiftUI


struct TrackingInfoView: View {
    @State var showMenu: Bool? = false
    
    var body: some View {
        
        ZStack {
            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    Circle()
                        .fill(ColorManager.defaultForegroundDisabled)
                        .frame(width: 54, height: 54)
                        .overlay(
                            Image("CJ_logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 39.7, height: 34.1)
                        )
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("토리든 다이브인 저분자 히알루론산 클렌징 폼 150ml")
                            .font(FontManager.title2)
                            .frame(maxWidth: 233, alignment: .leading)
    //                        .background(Color.red)
                        HStack(spacing: 8) {
                            Text("CJ 대한통운")
                            Text("123456789012")
                        }
                        .font(FontManager.caption1)
                        .foregroundColor(ColorManager.foreground1)
                    }
                        
                    Spacer()
                }
                
                VStack(spacing: 10) {
                    HStack(spacing: 10) {
                        TrackingInfoCardView(title: "받는 분", content: "박*환")
                        TrackingInfoCardView(title: "보내는 분", content: "토*든")
                    }
                    
                    HStack(spacing: 10) {
                        TrackingInfoCardView(title: "배송기사", content: "홍길동", deliveryman: true, show: $showMenu)
                        TrackingInfoCardView(title: "보내는 분", content: nil)
                    }
                }
                
                PromotionView(promotionTitle: "광고란", promotionContent: "광고입니다.")
                    .padding(.vertical, 8)
                Spacer()
            }
            .padding(.horizontal, 20)
            
            if showMenu ?? false {
                MenuView(show: $showMenu)
                    .animation(Animation.easeIn(duration: 2), value: showMenu)
            }
        }
        
        
    }
}

struct TrackingInfoCardView: View {
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
//                            withAnimation(Animation.easeIn(duration: 0.5)) {
//
//                            }
                            show?.toggle()
                            
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

struct MenuView: View {
    @Binding var show: Bool?
    
    init(show: Binding<Bool?> = .constant(nil)) {
        self._show = show
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    show = false
                }
                
            
            RoundedRectangle(cornerRadius: 16)
                .fill(ColorManager.background)
                .frame(width: 302, height: 204)
                .overlay(
                    VStack(spacing: 0) {
                        Button {
                            
                        } label: {
                            HStack {
                                Spacer()
                                Text("010-1234-5678 메세지 보내기")
                                    .font(FontManager.body2)
                                    .foregroundColor(ColorManager.defaultForeground)
                                Spacer()
                            }
                            .frame(height: 68)
                        }
                        
                        Divider()
                        
                        Button {
                            
                        } label: {
                            HStack {
                                Spacer()
                                Text("010-1234-5678 전화하기")
                                    .font(FontManager.body2)
                                    .foregroundColor(ColorManager.defaultForeground)
                                Spacer()
                            }
                            .frame(height: 68)
                        }
                        
                        Divider()
                        
                        Button {
                            
                        } label: {
                            HStack {
                                Spacer()
                                Text("기사님 번호 클립보드에 저장")
                                    .font(FontManager.body2)
                                    .foregroundColor(ColorManager.defaultForeground)
                                Spacer()
                            }
                            .frame(height: 68)
                        }
                    }
                
                )
        }
        
    }
}

struct TrackingInfoView_Previews: PreviewProvider {

    static let companyIdPreview = "04"
    static let invoiceNumberPreview = "1111111111"

    static var previews: some View {
        TrackingInfoView()
//        TrackingInfoCardView(title: "받는 분", content: "박*환")
    }
}

//struct TrackingInfoLoadingView: View {
//    @Binding var companyId: String
//    @Binding var invoiceNumber: String
//
//    var body: some View {
//        TrackingInfoView(companyId: companyId, invoiceNumber: invoiceNumber)
//    }
//
//}

//struct TrackingInfoView: View {
//
//    @StateObject private var trackingInfoVM: TrackingInfoService
//
//    init(companyId: String, invoiceNumber: String) {
//        _trackingInfoVM = StateObject(wrappedValue: TrackingInfoService(companyId, invoiceNumber))
//    }
//
//    var body: some View {
//        VStack(spacing: 20) {
////            Text(trackingInfoVM.trackingInfo.complete)
//            if let trackingInfo = trackingInfoVM.trackingInfo {
//                HStack {
//                    Text("배송 완료 여부 : ")
//                    Spacer()
//                    Text(trackingInfo.complete ? "Y" : "N")
//                }
//                .padding(.horizontal, 20)
//
//                HStack {
//                    Text("운송장 번호 : ")
//                    Spacer()
//                    Text(trackingInfo.invoiceNo)
//                }
//                .padding(.horizontal, 20)
//
//                List {
//                    // Identifiable 프로토콜 지우기
//                    // (ForEach(trackingInfo.trackingDetails.indices))
//                    // LazyVStack & LazyHStack 사용
//                    ForEach(trackingInfo.trackingDetails) { detail in
//                        VStack(alignment: .leading, spacing: 5) {
//                            Text("\(detail.level)")
//                            Text("\(detail.kind)")
//                                .bold()
//                        }
//                    }
//                }
//            } else {
//                Text("입력된 운송장 번호와 일치하는 정보를 찾을 수 없습니다.")
//            }
//
//        }
//
//    }
//}


