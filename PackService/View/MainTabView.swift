//
//  MainTabView.swift
//  PackService
//
//  Created by 이범준 on 1/8/23.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        VStack {
            TopOfTabView(title: "지금 배송중")
            
            SliderTabView() // 슬라이더 탭 뷰
            
            HStack {
                Text("인사이트")
                    .font(FontManager.title1)
                Spacer()
            }
            .padding(.top, -60) // 인사이트와 슬라이더 탭뷰와의 간격
            
            insightInfoView
            
            VStack {
                HStack {
                    PackInfoCell(title: "일일 최대 배송 개수", content: "5개")
                    PackInfoCell(title: "평균 배송 소요 시간", content: "1일 19시간 28분")
                }
                HStack {
                    PackInfoCell(title: "가장 빠른 지역", content: "용인시 수지구")
                    PackInfoCell(title: "가장 빠른 택배사", content: "CJ대한통운")
                }
                
            }
            .frame(height: 196)
            .padding(.trailing, 20)
            .padding(.top, 10)
            
            PromotionView(promotionTitle: "광고 제목", promotionContent: "광고 내용")
                .padding(.trailing, 20)
            Spacer()
        }
    }
}

extension MainTabView {
    var insightInfoView: some View {
        VStack { // 인사이트 정보
            HStack {
                Text("최단 시간 배송 완료")
                    .font(FontManager.caption1)
                    .padding(.leading, 20)
                Spacer()
                Text("신기록")
                    .font(FontManager.caption2)
                    .frame(width: 54, height: 20)
                    .foregroundColor(.white)
                    .background(ColorManager.primaryColor)
                    .cornerRadius(10)
                    .padding(.trailing, 20)
            }
            .padding(.top, 16)
            HStack {
                Text("1일 3시간 32분")
                    .font(FontManager.body1)
                    .padding(.leading, 20)
                Spacer()
            }
            Spacer()
        }
        .frame(height: 88)
        .background(ColorManager.background2)
        .cornerRadius(10)
        .padding(.trailing, 20)
        .padding(.top, -40) // 인사이트 글씨와 인사이트 정보 간격
    }
}

// MARK: - MainTabView의 SliderTabView
struct SliderTabView: View {
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .black
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.1)
    }
    var body: some View {
        let packageName: [String] = [
            "토리든 다이브인 저분자 하알루", "2번째 택배", "3번째 택배"
        ]
        let packageNumber: [String] = [
            "12345664343433", "343343545", "2453452345"
        ]
        let packageState: [String] = [
            "간선상차", "간선하차", "뭐시기"
        ]
        
        TabView {
            ForEach(0..<packageName.count) { item in
                ZStack {
                    VStack {
                        VStack {
                            
                            HStack {
                                Image(systemName: "gear")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                VStack {
                                    HStack {
                                        Text(packageName[item])
                                            .font(FontManager.title2)
                                        Spacer()
                                    }
                                    HStack {
                                        Text(packageNumber[item])
                                            .font(FontManager.caption1)
                                        Spacer()
                                        Text(packageState[item])
                                            .font(FontManager.caption1)
                                    }
                                }
                                Spacer()
                            }
                            .padding(.top, 24)
                            .padding(.leading, 16)
                            .padding(.trailing, 34)
                            
                            HStack {
                                ZStack(alignment: .leading) {
                                    Rectangle()
                                        .frame(width: 250, height: 12)
                                        .foregroundColor(ColorManager.background2)
                                    Image(systemName: "house.circle.fill")
                                        .resizable()
                                        .frame(width: 32, height: 32)
                                        .foregroundColor(ColorManager.background2)
                                        .background(ColorManager.foreground2)
                                        .clipShape(Circle())
                                        .padding(.leading, 232)
                                    OrderButton()
                                    Image(systemName: "shippingbox.circle.fill")
                                        .resizable()
                                        .frame(width: 32, height: 32)
                                        .foregroundColor(ColorManager.primaryColor)
                                        .background(ColorManager.background)
                                        .clipShape(Circle())
                                        .padding(.leading, -17)
                                }
                            }
                            Spacer()
                        }
                        .background( // slideTabView 그림자 넣기
                            ColorManager.background
                                .cornerRadius(10)
                                .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 2)
                        )
                        
                        Spacer()
                        
                        VStack { // 택배 상태 보여주는 탭뷰와 ... 간의 간격을 위함
                            
                        }
                        .padding(.top, 32)
                        
                    }
                }
            }
        }
        .frame(height: 170)
        .padding(.trailing, 20)
        .padding(.bottom, 40)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
    }
    
}

// MARK: - MaintabView에 있는 일일 최대, 가장 빠른 지역 등을 위한 PackInfoCell

struct PackInfoCell: View {
    var title: String
    var content: String
    var body: some View {
        
        ZStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(ColorManager.background)
                .padding(3)
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 4) {
                    Text(title)
                        .font(FontManager.caption1)
                    Image(systemName: "n.circle.fill")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundColor(ColorManager.primaryColor)
                }
                Text(content)
                    .font(FontManager.body1)
            }
            .frame(height: 40)
            .padding(.leading, 20)
        }
        .background( // slideTabView 그림자 넣기
            ColorManager.background
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 2)
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


struct TopOfTabView: View {
    var title: String
    var body: some View {
        HStack {
            Text(title)
                .font(FontManager.title1)
            Spacer()
            
            // 버튼 모양 수정 필요
            Button(action: {
                
            }, label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
            })
            .padding(.trailing, 20)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
