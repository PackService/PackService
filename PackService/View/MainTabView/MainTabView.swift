//
//  MainTabView.swift
//  PackService
//
//  Created by 이범준 on 1/8/23.
//

import SwiftUI

struct MainTabView: View {
    
    @EnvironmentObject var emailAuthVM: EmailService
    @EnvironmentObject var vm: MainViewModel
    @State var step: Double = 0.0
    @State var currentIndex: Int = 0
    @State var items: [TrackingInfoModel] = []
    @State var text: String = ""
    
    var body: some View {
        if !vm.isLoading {
            VStack(spacing: 8) {
                TopOfTabView(title: "지금 배송중")
                    .padding(.bottom, 8)
                
                carousel

                HStack {
                    Text("인사이트")
                        .font(FontManager.title1)
                    Spacer()
                }
                .padding(.top, 16)
                
                VStack {
                    insightInfoView
                    
                    HStack {
                        PackInfoCell(title: "일일 최대 배송 개수", content: "5개")
                        PackInfoCell(title: "평균 배송 소요 시간", content: "1일 19시간 28분")
                    }
                    HStack {
                        PackInfoCell(title: "가장 빠른 지역", content: "용인시 수지구")
                        PackInfoCell(title: "가장 빠른 택배사", content: "CJ 대한통운")
                    }
                }
                
                PromotionView(promotionTitle: "광고 제목", promotionContent: "광고 내용")
                    .padding(.top, 8)
                
                Spacer()
            }
            //            .onAppear {
            //                items.append(contentsOf: )
            ////                text = vm.trackingModels.debugDescription
            //            }
            .padding(.horizontal, 20)
        }
    }
}

struct TopOfTabView: View {
    var title: String
    var body: some View {
        HStack {
            Text(title)
                .font(FontManager.title1)
            
            Spacer()
            
            NavigationLink(destination: AddTrackingNumberView()) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .foregroundColor(ColorManager.primaryColor)
                    .frame(width: 32, height: 32)
            }

        }
    }
}


extension MainTabView {
    
    var carousel: some View {
        VStack(spacing: 0) {
            Carousel(index: $currentIndex, items: vm.carouselItems) { item in
                if item.company.isEmpty {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(ColorManager.background)
                            .shadow(color: Color.black.opacity(0.05), radius: 20, x: 0, y: 2)
                        
                        VStack(spacing: 12) {
                            Text("배송 추적할 운송장 번호을 등록해주세요")
                                .font(FontManager.title2)
                                .foregroundColor(ColorManager.foreground2)
                            
                            //Navigation Link
                            
                            NavigationLink(destination: AddTrackingNumberView()) {
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
                                        LogoType(rawValue: item.company ?? "00")?.logo.image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 44, height: 44)
                                    )
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(item.name)
                                        .font(FontManager.title2)
                                        .frame(maxWidth: 233, alignment: .leading)
                    //                        .background(Color.red)
                                    HStack(spacing: 8) {
                                        Text(item.invoice)
                                        Spacer()
                                        Text(item.itemWhere)
                                    }
                                    .font(FontManager.caption1)
                                    .foregroundColor(ColorManager.foreground1)
                                }
                            }
                            
                            TrackingProgressView2(currentStep: item.currentStep)
                                .padding(.top, 10)
                        }
                        .padding(.vertical, 24)
                        .padding(.horizontal, 16)
                    }
//                    .onAppear {
//                        step = item.currentStep
//                    }
                }
                
            }
            
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
    
    var insightInfoView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(ColorManager.background2)
                .shadow(color: Color.black.opacity(0.05), radius: 20, x: 0, y: 2)
            
            VStack { // 인사이트 정보
                HStack {
                    Text("최단 시간 배송 완료")
                        .font(FontManager.caption1)
                        .foregroundColor(ColorManager.foreground1)
                    Spacer()
                    Text("신기록")
                        .font(FontManager.caption2)
                        .frame(width: 54, height: 20)
                        .foregroundColor(.white)
                        .background(ColorManager.primaryColor)
                        .cornerRadius(10)
                }
                .padding(.top, 16)
                HStack {
                    Text("1일 3시간 32분")
                        .font(FontManager.body1)
                    Spacer()
                }
                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .frame(height: 88)
    }
}

//// MARK: - MainTabView의 SliderTabView
//struct SliderTabView: View {
//    @State var step: Double = 1
//    init() {
//        UIPageControl.appearance().currentPageIndicatorTintColor = .black
//        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.1)
//    }
//    var body: some View {
//        let packageName: [String] = [
//            "토리든 다이브인 저분자 하알루", "2번째 택배", "3번째 택배"
//        ]
//        let packageNumber: [String] = [
//            "12345664343433", "343343545", "2453452345"
//        ]
//        let packageState: [String] = [
//            "간선상차", "간선하차", "뭐시기"
//        ]
//        
//        TabView {
//            ForEach(0..<packageName.count) { item in
//                ZStack {
//                    VStack {
//                        VStack {
//                            
//                            HStack {
//                                Image(systemName: "gear")
//                                    .resizable()
//                                    .frame(width: 40, height: 40)
//                                VStack {
//                                    HStack {
//                                        Text(packageName[item])
//                                            .font(FontManager.title2)
//                                        Spacer()
//                                    }
//                                    HStack {
//                                        Text(packageNumber[item])
//                                            .font(FontManager.caption1)
//                                        Spacer()
//                                        Text(packageState[item])
//                                            .font(FontManager.caption1)
//                                    }
//                                }
//                                Button {
//                                    step += 1
//                                } label: {
//                                    Image(systemName: "arrow.clockwise.circle.fill")
//                                        .renderingMode(.template)
//                                        .resizable()
//                                        .frame(width: 24, height: 24)
//                                        .foregroundColor(ColorManager.primaryColor)
//                                }
//                                Spacer()
//                            }
//                            .padding(.top, 24)
//                            .padding(.leading, 16)
//                            .padding(.trailing, 34)
//                            
////                            HStack {
////                                ZStack(alignment: .leading) {
////                                    Rectangle()
////                                        .frame(width: 250, height: 12)
////                                        .foregroundColor(ColorManager.background2)
////                                    Image(systemName: "house.circle.fill")
////                                        .resizable()
////                                        .frame(width: 32, height: 32)
////                                        .foregroundColor(ColorManager.background2)
////                                        .background(ColorManager.foreground2)
////                                        .clipShape(Circle())
////                                        .padding(.leading, 232)
////                                    OrderButton()
////                                    Image(systemName: "shippingbox.circle.fill")
////                                        .resizable()
////                                        .frame(width: 32, height: 32)
////                                        .foregroundColor(ColorManager.primaryColor)
////                                        .background(ColorManager.background)
////                                        .clipShape(Circle())
////                                        .padding(.leading, -17)
////                                }
////                            }
////                            Spacer()
//                            VStack {
//                                Group {
//                                    TrackingProgressView2(currentStep: $step)
//                                        .frame(height: 32)
//                                        .padding(.top, 24)
//                                        .padding(.horizontal, 12)
//                                        .animation(Animation.easeIn(duration: 1.0), value: step)
//                                        .onAppear {
//                                            step = 0
//                                        }
//                                    //                        .background(Color.red)
//                                    
//                                    var arr = ["군포", "기흥", nil, "죽전"]
//                                    
//                                    HStack {
//                                        ForEach(arr, id: \.self) { item in
//                                            Text(item ?? "(정보없음)")
//                                                .font(FontManager.caption1)
//                                                .foregroundColor(item != arr[Int(step)] ? ColorManager.foreground1 : ColorManager.primaryColor)
//                                            //                        Text((dict[key] ?? "(정보없음)") ?? "(정보없음)")
//                                            if item != arr.last! {
//                                                Spacer()
//                                            }
//                                            
//                                        }
//                                    }
//                                    .padding(.horizontal, 20)
//                                    .padding(.bottom, 8)
//                                }
//                            }
//                        }
//                        .background( // slideTabView 그림자 넣기
//                            ColorManager.background
//                                .cornerRadius(10)
//                                .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 2)
//                        )
//                        
//                        Spacer()
//                        
//                        VStack { // 택배 상태 보여주는 탭뷰와 ... 간의 간격을 위함
//                            
//                        }
//                        .padding(.top, 32)
//                        
//                    }
//                }
//            }
//        }
//        .frame(height: 170)
//        .padding(.trailing, 20)
//        .padding(.bottom, 40)
//        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
//    }
//    
//}

// MARK: - MaintabView에 있는 일일 최대, 가장 빠른 지역 등을 위한 PackInfoCell

struct PackInfoCell: View {
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
                    Image(systemName: "n.circle.fill")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundColor(ColorManager.primaryColor)
                }
                Text(content)
                    .font(FontManager.body1)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            
        }
        .frame(height: 88)
        .background( // slideTabView 그림자 넣기
            ColorManager.background
                .cornerRadius(10)
                
        )
    }
    
}

// MARK: - MainTabView의 ProgressBar
// progressbar animation
enum OrderStatus {
    case ready
    case started
    case finished
}

struct OrderButton: View {

    @State private var status: OrderStatus = .ready

    private var progressBarWidth: CGFloat = 250
    private var animationTime: TimeInterval = 0.4
    private var progressBarAnimationTime: TimeInterval = 3

    @State private var isPlaced = false

    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Rectangle()
                        .fill(ColorManager.primaryColor)
                        .frame(height: 12)
                        .animation(.linear(duration: (status == .finished) ? progressBarAnimationTime : progressBarAnimationTime))
                    Spacer()
                        .frame(width:(status == .ready) ? progressBarWidth : 0)
                }
                .frame(width: progressBarWidth)
                
                ZStack {
                    VStack {
                        HStack {
                            Spacer()
                                .frame(width:(status == .ready) ? 0: 250) // box 움직임을 위한 프레임
                            
                            TruckView()
                                .foregroundColor(ColorManager.primaryColor)
                                .background(ColorManager.background)
                                .clipShape(Circle())
                                .animation(Animation.linear(duration: (status == .started) ? progressBarAnimationTime : animationTime).delay(0))
                            
                            Spacer()
                                .frame(width:(status == .ready) ? 250 : 0)
                        }
                        .frame(width: progressBarWidth)
                    }
                }
            }
            .frame(width: progressBarWidth)
        }
        .onAppear {
            download()
        }
    }

    func download() {
        isPlaced.toggle()
        Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false) { timer in
            status = .started
        }
        Timer.scheduledTimer(withTimeInterval: 4.5, repeats: false) { timer in
            status = .finished
        }
    }

}

struct TruckView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(ColorManager.primaryColor)
                .frame(width: 32, height: 32)
            Image(systemName: "box.truck")
                .resizable()
                .foregroundColor(.white)
                .symbolVariant(.fill)
                .frame(width: 20.8, height: 14.9)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
