//
//  MainView.swift
//  PackService
//
//  Created by 이범준 on 1/4/23.
//

import SwiftUI

// MARK: - MainView
struct MainView: View {
    let packageName: [String] = [ // 추후 slidertabview에 있는거 빼오기
        "토리든 다이브인 저분자 하알루", "2번째 택배", "3번째 택배"
    ]
    let packageNumber: [String] = [
        "12345664343433", "343343545", "2453452345"
    ]
    let packageState: [String] = [
        "간선상차", "간선하차", "뭐시기"
    ]
    
    var body: some View {
        TabView {
            mainTabView
                .tabItem{
                    Image(systemName: "house")
                        .environment(\.symbolVariants, .none)
                }
            packListTabView
                .tabItem {
                    Image(systemName: "shippingbox")
                        .environment(\.symbolVariants, .none)
                }
            systemTabView
                .tabItem {
                    Image(systemName: "gearshape")
                        .environment(\.symbolVariants, .none)
                }
        }
        .padding(.leading, 20)
        .padding(.top, 20)
        .accentColor(ColorManager.primaryColor)
    }
    
}

// MARK: - MainTabView
extension MainView {
    var mainTabView: some View { // mainTabView
        VStack {
            HStack {
                Text("지금 배송중")
                    .font(FontManager.title1)
                Spacer()
                
                //버튼 모양 수정 필요
                Button(action: {
                    
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
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
            
            promotionView
            Spacer()
        }
    }
    
// MARK: - promotionView
    var promotionView: some View {
        VStack {
            HStack {
                Text("(광고) 한여름에 뭐시기 저시기")
                    .font(FontManager.body1)
                    .padding(.leading, 20)
                Spacer()
            }
            .padding(.top, 20)
            HStack {
                Text("카카오가 주관하는 뭐시기 저시기니까 그런줄 아셈")
                    .font(FontManager.caption1)
                    .padding(.leading, 20)
                Spacer()
            }
            .padding(.top, 16)
            Spacer()
        }
        .background(ColorManager.background2)
        .cornerRadius(10)
        .padding(.top,16)
        .padding(.trailing, 20)
    }
    
}

extension MainView {
    var packListTabView: some View {
        VStack {
            HStack {
                Text("배송 목록")
                    .font(FontManager.title1)
                
                Spacer()
                Button(action: {
                    
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
                })
                .padding(.trailing, 20)
            }
            Text("search")
            
            ScrollView {
                LazyVStack {
                    ForEach(0..<packageName.count) { item in
                        // 배송 진행중인 목록 보여주는 곳
                        CurrentPackageCell(packageName: packageName[item], packageNumber: packageNumber[item], packageState: packageNumber[item])
                    }
                }
            }
            .padding(.trailing, 20)
            
            Spacer()
        }

    }
}

struct CurrentPackageCell {
    var packageName: String
    var packageNumber: String
    var packageState: String
    
    var body: some View {
        HStack {
            VStack {
                Text(packageName)
                Text(packageNumber)
                Text(packageState)
            }
        }
        .frame(height: 76)
    }
}

// MARK: - SystemTabView

extension MainView {
    var systemTabView: some View {
        VStack {
            Text("설정")
                .font(FontManager.title2)
            
            VStack(spacing: 10) {
                SystemButtonView(buttonType: .arrow, text: "계정", email: "abc@naver.com")
                SystemButtonView(buttonType: .toggle, text: "알림설정")
                SystemButtonView(buttonType: .arrow, text: "이용약관")
                SystemButtonView(buttonType: .arrow, text: "개인정보처리방침")
                SystemButtonView(buttonType: .version, text: "현재 버전")
                SystemButtonView(buttonType: .arrow, text: "피드백 보내기")
            }
            .padding(.top, 26)
            
            Spacer()
        }
        .padding(.trailing, 20)
    }
}

struct SystemButtonView: View {
    
    @State private var alarmToggle = true
    var buttonType: ButtonType
    var text: String
    var email: String?
    var version: String?
    
    enum ButtonType {
        case arrow
        case toggle
        case version
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(height: 48)
                .foregroundColor(ColorManager.background2)
                .cornerRadius(10)
            HStack {
                Text(text)
                    .padding(.leading, 20)
                    .font(FontManager.body2)
                Spacer()
                switch buttonType {
                case .arrow:
                    Text(email ?? "")
                        .padding(.trailing, 14.9)
                        .font(FontManager.body2)
                        .foregroundColor(ColorManager.primaryColor)
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: 10.1, height: 17.6)
                        .padding(.trailing, 26.9)
                case .toggle:
                    Toggle("", isOn: $alarmToggle)
                        .padding(.trailing, 20)
                case .version:
                    Text(version ?? "0.0.1")
                        .padding(.trailing, 20)
                        .font(FontManager.body2)
                        .foregroundColor(ColorManager.primaryColor)
                }
            }
        }
    }
}

// MARK: - SliderTabView

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

// MARK: - PackInfoCell

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

// MARK: - ProgressBar
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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
