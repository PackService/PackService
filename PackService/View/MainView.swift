//
//  MainView.swift
//  PackService
//
//  Created by 이범준 on 1/4/23.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        TabView {
            VStack {
                HStack {
                    Text("지금 배송중")
                        .font(FontManager.title1)
                    Spacer()
                    
                    //버튼 모양 수정 필요
                    Button(action: {
                        
                    }, label: {
                        ToggleButtonView(agree: true)
                    })
                    .padding(.trailing, 20)
                }
                
                SliderTabView() // 슬라이더 탭 뷰
                
                HStack {
                    Text("인사이트")
                        .font(FontManager.title1)
                    Spacer()
                }
                .padding(.top, -60) //인사이트와 슬라이더 탭뷰와의 간격
                
                VStack { // 인사이트 정보
                    HStack {
                        Text("최단 시간 배송 완료")
                            .font(FontManager.caption1)
                            .padding(.leading, 20)
                        Spacer()
                        Text("신기록")
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
                .padding(.trailing, 20)
                .padding(.top, -40) // 인사이트 글씨와 인사이트 정보 간격
                
                VStack { // 함수화 해야함
                    HStack {
                        ZStack {
                            Rectangle()
                                .foregroundColor(ColorManager.background)
                                .padding(3)
                            PackInfoCell()
                        }
                        ZStack {
                            Rectangle()
                                .foregroundColor(ColorManager.background)
                                .padding(3)
                            PackInfoCell()
                        }
                    }
                    HStack {
                        ZStack {
                            Rectangle()
                                .foregroundColor(ColorManager.background)
                                .padding(3)
                            PackInfoCell()
                        }
                        ZStack {
                            Rectangle()
                                .foregroundColor(ColorManager.background)
                                .padding(3)
                            PackInfoCell()
                        }
                    }
                }
                .frame(height: 196)
                .background(ColorManager.background2)
                .padding(.trailing, 20)
                .padding(.top, 10)
                
                Rectangle()
                    .padding(.top, 16)
                    .padding(.trailing, 20)
                    .foregroundColor(ColorManager.primaryColor)
                    
                Spacer()
            }
            .tabItem{
                Image(systemName: "house.fill")
            }
            
            
            
            //비어있는 버튼으로 수정해야됨
            // 배송 탭
            VStack {
                Text("shipping Tab")
                Spacer()
            }
                .tabItem {
                    Image(systemName: "shippingbox")
                        .foregroundColor(Color.red)
                }
            
            // 설정 탭
            Text("System Tab")
                .tabItem {
                    Image(systemName: "gearshape")
                }
        }
        .padding(.leading, 20)
        .padding(.top, 20)
        .accentColor(ColorManager.primaryColor)
    }
    
}

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
                                        .frame(width: 30, height: 32)
                                        .foregroundColor(ColorManager.primaryColor)
                                        .background(ColorManager.background)
                                        .clipShape(Circle())
                                        .padding(.leading, -17)
                                }
                            }
                            Spacer()
                        }
                        .background(ColorManager.background)
                        .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .strokeBorder(ColorManager.background2, lineWidth: 5)
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

struct PackInfoCell: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("일일 최대 배송 개수")
                .padding(.bottom, 8)
                .font(FontManager.caption1)
            Text("5개")
                .font(FontManager.body1)
        }
        .frame(height: 40)
    }
    
}

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
                }.frame(width: progressBarWidth)
                
                ZStack {
                    HStack {
                        Spacer()
                            .frame(width:(status == .ready) ? 0: 250) // box 움직임을 위한 프레임

                        Image(systemName: "shippingbox.circle.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundColor(ColorManager.primaryColor)
                            .background(ColorManager.background)
                            .clipShape(Circle())
                            .animation(Animation.linear(duration: (status == .started) ? progressBarAnimationTime : animationTime).delay(0))
                        Spacer()
                            .frame(width:(status == .ready) ? 250 : 0)
                    }.frame(width: progressBarWidth)
                }
            }.frame(width: progressBarWidth)

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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
