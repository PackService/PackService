//
//  MainTabView.swift
//  PackService
//
//  Created by 이범준 on 1/8/23.
//

import SwiftUI
import FirebaseAuth

//MARK: - MainTabView
struct MainTabView: View {
    @State var firstNaviLinkActive = false
    @EnvironmentObject var service: LoginService
    @EnvironmentObject var vm: MainViewModel
//    @State var step: Double = 0.0
    @State var currentIndex: Int = 0
//    @State var items: [TrackingInfoModel] = []
//    @State var text: String = ""
    @State var isDragging: Bool = false
    
    var body: some View {
        if Auth.auth().currentUser != nil {
            VStack(spacing: 8) {
                //Header
                HeaderView(title: "지금 배송중")
                    .padding(.bottom, 8)
                
                //Carousel
                carousel

                HStack {
                    Text("대시보드")
                        .font(FontManager.title1)
                    Spacer()
                }
                .padding(.top, 16)
                
                //Dashboard
                dashboard
                
//                //Promotion
//                PromotionView(promotionTitle: "광고 제목", promotionContent: "광고 내용")
//                    .padding(.top, 8)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .onAppear {
                service.readTrackNumber()
            }
            
        }
    }
}

//MARK: - HeaderView
struct HeaderView: View {
    @State var firstNaviLinkActive = false
    var title: String
    var body: some View {
        HStack {
            Text(title)
                .font(FontManager.title1)
            
            Spacer()
            
            NavigationLink(destination: AddTrackingNumberView(firstNaviLinkActive: $firstNaviLinkActive), isActive: $firstNaviLinkActive) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .foregroundColor(ColorManager.primaryColor)
                    .frame(width: 32, height: 32)
            }

        }
    }
}

extension MainTabView {
    //MARK: - Carousel
    var carousel: some View {
        VStack(spacing: 0) {
            Carousel(index: $currentIndex, isDragging: $isDragging, items: vm.carouselItems) { item in
                if item.company.isEmpty {
                    //Empty Carousel
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(ColorManager.background)
                            .shadow(color: Color.black.opacity(0.05), radius: 20, x: 0, y: 2)
                        
                        VStack(spacing: 12) {
                            Text("배송 추적할 운송장 번호을 등록해주세요")
                                .font(FontManager.title2)
                                .foregroundColor(ColorManager.foreground2)
                       
                            NavigationLink(destination: AddTrackingNumberView(firstNaviLinkActive: $firstNaviLinkActive), isActive: $firstNaviLinkActive) {
                                Text("등록")
                                    .font(FontManager.title2)
                                .foregroundColor(ColorManager.primaryColor)
                                .overlay(
                                        Rectangle()
                                            .frame(height: 1.2)
                                            .offset(y: 2)
                                            .foregroundColor(ColorManager.primaryColor)
                                        , alignment: .bottom)
                            }
                            
                        }
                    }
                } else {
                    //Carousel with items
                    NavigationLink {
                        TrackingDetailLoadingView(company: item.company, invoice: item.invoice, item: item.name)
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(ColorManager.background)
                                .shadow(color: Color.black.opacity(0.05), radius: 20, x: 0, y: 2)
                            
                            VStack {
                                HStack(spacing: 12) {
                                    Circle()
                                        .fill(ColorManager.defaultForegroundDisabled)
                                        .frame(width: 44, height: 44)
                                        .overlay(
                                            LogoType(rawValue: item.company)?.logo.image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 44, height: 44)
                                        )
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(item.name)
                                            .font(FontManager.title2)
                                            .frame(maxWidth: 233, alignment: .leading)
                                        HStack(spacing: 8) {
                                            Text(item.invoice)
                                            Spacer()
                                            Text(item.itemWhere)
                                        }
                                        .font(FontManager.caption1)
                                        .foregroundColor(ColorManager.foreground1)
                                    }
                                }
                                
                                TrackingStatusView(currentStep: item.currentStep)
                                    .padding(.top, 10)
                            }
                            .padding(.vertical, 24)
                            .padding(.horizontal, 16)
                        }
                    }
                    .buttonStyle(CarouselButtonStyle(isDragging: $isDragging))
                }
                
            }
            
            //Pagination
            HStack(spacing: 8) {
                ForEach(vm.carouselItems.indices, id: \.self) { index in
                    Circle()
                        .fill(Color.black.opacity(currentIndex == index ? 1 : 0.1))
                        .frame(width: 8, height: 8)
                        .animation(.spring(), value: currentIndex == index)
                }
            }
        }
        .frame(height: 180)
    }
    
    //MARK: - Dashboard
    var dashboard: some View {
        VStack {
            ZStack {
                //background
                RoundedRectangle(cornerRadius: 10)
                    .fill(ColorManager.background2)
                    .shadow(color: Color.black.opacity(0.05), radius: 20, x: 0, y: 2)
                
                //contents
                HStack {
                    VStack(spacing: 8) {
                        HStack {
                            Text("최근 조회한 물품")
                                .font(FontManager.caption1)
                                .foregroundColor(ColorManager.foreground1)
                            Spacer()
                        }
                        
                        HStack {
                            Text(vm.historyItem)
                                .font(FontManager.body1)
                            Spacer()
                        }
                                           
                    }
                    
                    NavigationLink {
                        TrackingDetailLoadingView(company: vm.historyCompany ?? "", invoice: vm.historyInvoice ?? "", item: vm.historyItem)
                    } label: {
                        Image(systemName: "arrow.right")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                            .font(FontManager.body1)
                            .foregroundColor(ColorManager.background)
                            .padding(8)
                    }
                    .buttonStyle(InsightButtonStyle())
                    .disabled(vm.historyItem == "최근 사용한 기록이 없습니다")
                }
                .padding(.horizontal, 20)
            }
            .frame(height: 88)
            
            HStack {
                InsightCellView(title: "배송중인 운송장 개수", content: "\(vm.total-vm.completed)개")
                InsightCellView(title: "등록된 운송장 개수", content: "총 \(vm.total)개")
                
            }
            HStack {                
                InsightCellView(title: "완료된 운송장 개수", content: "\(vm.completed)개 완료")
                InsightCellView(title: "가장 많이 이용한 택배사", content: "\(vm.mostUsed)")
            }
        }
        
    }
}

// MARK: - InsightCellView
struct InsightCellView: View {
    var title: String
    var content: String
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(ColorManager.background)
                .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 2)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 4) {
                    Text(title)
                        .font(FontManager.caption1)
                        .foregroundColor(ColorManager.foreground1)
                }
                Text(content)
                    .font(FontManager.body1)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            
        }
        .frame(height: 88)
        .background(
            ColorManager.background
                .cornerRadius(10)
        )
    }    
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
