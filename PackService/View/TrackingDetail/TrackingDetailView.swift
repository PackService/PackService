//
//  TrackingInfoView.swift
//  PackService
//
//  Created by 박윤환 on 2022/12/26.
//

import SwiftUI

struct TrackingDetailView: View {
    @State var showMenu: Bool? = false
    
    var body: some View {
        ZStack {
            ScrollView {
                ZStack {
                    VStack(spacing: 16) {
                        header
                        
                        cardView
                        
                        PromotionView(promotionTitle: "광고란", promotionContent: "광고입니다.")
                            .padding(.vertical, 8)
                        
                        TrackingPositionView()
                        
                        Spacer()
                        
                    }
                    .padding(.horizontal, 20)
                        
                }
                .frame(maxHeight: .infinity)
            }
            
            if showMenu ?? false {
                MenuView(show: $showMenu)
                    .animation(Animation.easeIn(duration: 2), value: showMenu)
            }
        } 
    }
}

extension TrackingDetailView {
    var header: some View {
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
    }
    
    var cardView: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                TrackingDetailCardView(title: "받는 분", content: "박*환")
                TrackingDetailCardView(title: "보내는 분", content: "토*든")
            }
            
            HStack(spacing: 10) {
                TrackingDetailCardView(title: "배송기사", content: "홍길동", deliveryman: true, show: $showMenu)
                TrackingDetailCardView(title: "예상 완료 시간", content: nil)
            }
        }
    }
}

//MARK: - Previews
struct TrackingDetailView_Previews: PreviewProvider {

    static let companyIdPreview = "04"
    static let invoiceNumberPreview = "1111111111"

    static var previews: some View {
        
        Group {
            TrackingDetailView()
            TrackingPositionListCellView(status: "집화처리", position: "군포직영", deliveryMan: "홍길동", time: "07:48", date: "2022.11.22", isCurrent: true)
        }
        
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


