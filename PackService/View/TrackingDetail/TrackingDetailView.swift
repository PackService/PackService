//
//  TrackingInfoView.swift
//  PackService
//
//  Created by 박윤환 on 2022/12/26.
//

import SwiftUI
import Foundation

struct TrackingDetailLoadingView: View {
    @Environment(\.dismiss) private var dismissTrackingDetailView
    var companyId: String
    var invoiceNumber: String
    var item: String

    var body: some View {
        TrackingDetailView(companyId: companyId, invoiceNumber: invoiceNumber)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle(item)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismissTrackingDetailView()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(ColorManager.defaultForeground)
                    }
                }
            }
    }

}

struct TrackingDetailView: View {
    @StateObject private var trackingDetailVM: TrackingInfoViewModel
    
    @State var showMenu: Bool? = false
    @State var showToast: Bool = false
    var code: String = "111"
    var invoice: String = "111"
    
    //MARK: - Initializer
    init(companyId: String, invoiceNumber: String) {
        _trackingDetailVM = StateObject(wrappedValue: TrackingInfoViewModel(code: companyId, invoice: invoiceNumber))
        self.code = companyId
        self.invoice = invoiceNumber
    }
    
    var body: some View {
//         else {
            ZStack {
                ScrollView {
                    ZStack(alignment: .bottom) {
                        VStack(spacing: 16) {
                            //header
                            headerView
                            
                            //infos on card
                            cardView
                            
                            //promotion
                            PromotionView(promotionTitle: "광고란", promotionContent: "광고입니다.")
                                .padding(.vertical, 8)

                            //tracking position
                            TrackingPositionView(code: code, invoice: invoice)
                            
                            Text("\(trackingDetailVM.currentStep)")
                            Spacer()
                            
                        }
                        .padding(.horizontal, 20)
                        
                    }
                    .frame(maxHeight: .infinity)
                    
                }
                
                if showMenu ?? false {
                    MenuView(show: $showMenu, showToast: $showToast, tel: trackingDetailVM.deliveryManContact)
                        .animation(Animation.easeIn(duration: 2), value: showMenu)
                }
                
                if trackingDetailVM.isLoading {
                    LoadingView()
                        .onAppear {
                            // 만약 1.5초보다 많은 로딩 시간이 걸린다면??
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                trackingDetailVM.isLoading = false
                            }
                        }
                }
     
            }
            .environmentObject(trackingDetailVM)
            .alert("오류", isPresented: $trackingDetailVM.showAlert) {
                Button("OK") {}
            } message: {
                Text("[\(trackingDetailVM.alertTitle)] " + trackingDetailVM.alertMessage)
            }
            .toast(isShowing: $showToast)
//        }
        
    }
}

extension TrackingDetailView {
    //MARK: - Header
    var headerView: some View {
        HStack(spacing: 16) {
            Circle()
                .fill(ColorManager.defaultForegroundDisabled)
                .frame(width: 54, height: 54)
                .overlay(
                    LogoType(rawValue: trackingDetailVM.code)?.logo.image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 54, height: 54)
                )
            
            VStack(alignment: .leading, spacing: 8) {
                Text(!trackingDetailVM.item.isEmpty ? trackingDetailVM.item :  "\(trackingDetailVM.invoice) 물품")
                    .font(FontManager.title2)
                    .frame(maxWidth: 233, alignment: .leading)
//                        .background(Color.red)
                HStack(spacing: 8) {
                    Text(trackingDetailVM.name ?? "택배사 이름")
                    Text(trackingDetailVM.invoice)
                }
                .font(FontManager.caption1)
                .foregroundColor(ColorManager.foreground1)
            }
                
            Spacer()
        }
    }
    
    //MARK: - Card View
    var cardView: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                TrackingDetailCardView(title: "받는 분", content: trackingDetailVM.receiver)
                TrackingDetailCardView(title: "보내는 분", content: trackingDetailVM.sender)
            }
            
            HStack(spacing: 10) {
                TrackingDetailCardView(title: "배송기사", content: trackingDetailVM.deliveryMan, deliveryman: true, show: $showMenu)
                TrackingDetailCardView(title: "예상 완료 시간", content: trackingDetailVM.estimate ?? "", isComplete: trackingDetailVM.isComplete)
            }
        }
    }
}

//MARK: - Previews
struct TrackingDetailView_Previews: PreviewProvider {

    static let companyIdPreview = "04"
    static let invoiceNumberPreview = "1111111111"

    static var previews: some View {
        TrackingDetailView(companyId: "01", invoiceNumber: "6096353177732")
    }
}
