//
//  TrackingInfoView.swift
//  PackService
//
//  Created by 박윤환 on 2022/12/26.
//

import SwiftUI
import Foundation

//MARK: - TrackingDetailLoadingView
struct TrackingDetailLoadingView: View {
    @EnvironmentObject var service: LoginService
    @Environment(\.dismiss) private var dismissTrackingDetailView
    
    var company: String
    var invoice: String
    var item: String

    var body: some View {
        TrackingDetailView(company: company, invoice: invoice, item: item)
            .onAppear {
                service.updateHistory(company: company, invoice: invoice)
            }
    }

}

struct TrackingDetailView: View {
    @Environment(\.dismiss) private var dismissTrackingDetailView
    @StateObject private var vm: TrackingInfoViewModel
    
    @State var showMenu: Bool? = false
    @State var showToast: Bool = false
    @State var showSheet: Bool = false
    
    var company: String = "111"
    var invoice: String = "111"
    var item: String = "111"
    
    //MARK: - Initializer
    init(company: String, invoice: String, item: String) {
        _vm = StateObject(wrappedValue: TrackingInfoViewModel(company: company, invoice: invoice))
        self.company = company
        self.invoice = invoice
        self.item = item
    }
    
    var body: some View {
        ZStack {
            VStack {
                Divider()
                
                ScrollView {
                    ZStack(alignment: .bottom) {
                        VStack(spacing: 16) {
                            //header
                            headerView
                            
                            //infos on card
                            cardView
                            
                            //promotion
//                            PromotionView(promotionTitle: "광고란", promotionContent: "광고입니다.")
//                                .padding(.vertical, 8)

                            //tracking position
                            TrackingPositionView(code: company, invoice: invoice)
                            
                            Spacer()
                            
                        }
                        .padding(.horizontal, 20)
                        
                    }
                    .frame(maxHeight: .infinity)
                    
                }
            }
            
            if showMenu ?? false {
                MenuView(show: $showMenu, showToast: $showToast, tel: vm.deliveryManContact)
                    .animation(Animation.easeIn(duration: 2), value: showMenu)
                    .zIndex(2)
            }
            
            if vm.isLoading {
                LoadingView()
                    .onAppear {
                        // 만약 1.5초보다 많은 로딩 시간이 걸린다면??
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            vm.isLoading = false
                        }
                    }
            }
            
            ActionSheetView(show: $showSheet, company: company, companyName: vm.companyName ?? "", invoice: invoice)
 
        }
        .environmentObject(vm)
        .alert("오류", isPresented: $vm.showAlert) {
            Button("OK") {}
        } message: {
            Text("[\(vm.alertTitle)] " + vm.alertMessage)
        }
        .toast(isShowing: $showToast)
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
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showSheet.toggle()
                } label: {
                    Image(systemName: "ellipsis")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(ColorManager.defaultForeground)
                }
            }
        }
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
                    LogoType(rawValue: vm.company)?.logo.image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 54, height: 54)
                )
            
            VStack(alignment: .leading, spacing: 8) {
                Text(!vm.item.isEmpty ? vm.item :  "\(vm.invoice) 물품")
                    .font(FontManager.title2)
                    .frame(maxWidth: 233, alignment: .leading)
//                        .background(Color.red)
                HStack(spacing: 8) {
                    Text(vm.companyName ?? "택배사 이름")
                    Text(vm.invoice)
                }
                .font(FontManager.caption1)
                .foregroundColor(ColorManager.foreground1)
            }
                
            Spacer()
        }
        .padding(.top, 20)
    }
    
    //MARK: - Card View
    var cardView: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                TrackingDetailCardView(title: "받는 분", content: vm.receiver)
                TrackingDetailCardView(title: "보내는 분", content: vm.sender)
            }
            
            HStack(spacing: 10) {
                TrackingDetailCardView(title: "배송기사", content: vm.deliveryMan, deliveryman: true, show: $showMenu)
                TrackingDetailCardView(title: "예상 완료 시간", content: vm.estimate ?? "", isComplete: vm.isComplete)
            }
        }
    }
}

////MARK: - Previews
//struct TrackingDetailView_Previews: PreviewProvider {
//
//    static let companyIdPreview = "04"
//    static let invoiceNumberPreview = "1111111111"
//
//    static var previews: some View {
//        TrackingDetailView(companyId: "08", invoiceNumber: "248569159322")
//    }
//}
