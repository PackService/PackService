//
//  MainView.swift
//  PackService
//
//  Created by 이범준 on 1/4/23.
//

import SwiftUI

// MARK: - MainView
struct MainView: View {
    @State var tapped = false

    var tap: some Gesture {
        TapGesture(count: 1)
            .onEnded { _ in self.tapped = !self.tapped }
    }
    
    @State var serviceAgreeScreen: Bool = false
    @State var packInfoModel = [ // 모델에서 받아올때 이부분 수정해야될듯
        PackInfoModel(packageNumber: "1213214234", packageName: "첫번째 택배", packageArrvieTime: "12/29", packageState: "배송중"),
        PackInfoModel(packageNumber: "94894899834", packageName: "두번째 택배", packageArrvieTime: "12/29", packageState: "배송 완료"),
        PackInfoModel(packageNumber: "493048234", packageName: "세번째 택배", packageArrvieTime: "12/29", packageState: "배송중"),
        PackInfoModel(packageNumber: "49304823422", packageName: "세번째 택배", packageArrvieTime: "12/29", packageState: "배송중"),
        PackInfoModel(packageNumber: "49304823454", packageName: "세번째 택배", packageArrvieTime: "12/29", packageState: "배송중"),
        PackInfoModel(packageNumber: "4930482344", packageName: "세번째 택배", packageArrvieTime: "12/29", packageState: "배송중"),
        PackInfoModel(packageNumber: "4930483234", packageName: "세번째 택배", packageArrvieTime: "12/29", packageState: "배송중"),
        PackInfoModel(packageNumber: "4930483134", packageName: "세번째 택배", packageArrvieTime: "12/29", packageState: "배송중"),
        PackInfoModel(packageNumber: "4930413234", packageName: "세번째 택배", packageArrvieTime: "12/29", packageState: "배송중"),
        PackInfoModel(packageNumber: "4930383234", packageName: "세번째 택배", packageArrvieTime: "12/29", packageState: "배송중"),
        PackInfoModel(packageNumber: "49383234", packageName: "세번째 택배", packageArrvieTime: "12/29", packageState: "배송중")
    ]
    
    var body: some View {
        TabView {
            MainTabView()
                .tabItem {
                    Image(systemName: "house")
                        .environment(\.symbolVariants, .none)
                }
            packListTabView
                .tabItem {
                    Image(systemName: "shippingbox")
                        .environment(\.symbolVariants, .none)
                }
            SystemTabView()
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

// MARK: - 2번째 TabView
extension MainView {
    var packListTabView: some View {
        VStack {
            TopOfTabView(title: "배송 목록")
            
            // 검색 텍스트필드 해야함
            SearchTextField(title: "검색")
            
            List {
                ForEach(packInfoModel, id: \.packageNumber) { packInfo in
                    // 배송 진행중인 목록 보여주는 곳
                    SwipeItem(content: {
                        HStack {
                            Spacer()
                            VStack {
                                HStack {
                                    Image(systemName: "circle.fill")
                                        .resizable()
                                        .frame(width: 44, height: 44)
                                    VStack(alignment: .leading) {
                                        Text(packInfo.packageName)
                                            .font(FontManager.title3)
                                            .padding(.bottom, 2)
                                        HStack {
                                            Text(packInfo.packageNumber)
                                                .font(FontManager.caption1)
                                                .foregroundColor(ColorManager.foreground1)
                                            Spacer()
                                            Text(packInfo.packageArrvieTime)
                                                .font(FontManager.caption1)
                                                .foregroundColor(ColorManager.foreground1)
                                                .padding(.trailing, 8)
                                            Text(packInfo.packageState)
                                                .font(FontManager.caption2)
                                                .foregroundColor(ColorManager.primaryColor)
                                        }
                                    }
                                    .padding(.leading, 16)
                                    Spacer()
                                }
                                .padding(16)
                            }
                            Spacer()
                        }
                    }, right: {
                        ZStack {
                            Rectangle()
                                .fill(Color.red)
                                .cornerRadius(10)
                            Button(action: { //이것도 탭 제스쳐로 해
                                
                            }, label: {
                                Text("삭제하기")
                            })
                            
                        }
                        .padding(.trailing, 20)
                    }, itemHeight: 76)
                    .listRowSeparator(.hidden)
                }
                // 탭 했을 때 색 변경 추가해야됨
//                .background(self.tapped ? Color.blue : Color.red)
//                            .gesture(tap)
                
                .background( // slideTabView 그림자 넣기
                    ColorManager.background
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 2)
                )
                .frame(height: 80)
                Spacer()
            }
            .padding(.leading, -17)
            .listRowInsets(EdgeInsets())
            .listStyle(PlainListStyle())
            
            Spacer()
        }
    }
}

struct SwipeItem<Content: View, Right:View>: View {
    var packInfoModel: PackInfoModel?
    var content: () -> Content
    var right: () -> Right
    var itemHeight: CGFloat
    
    init(content: @escaping () -> Content, right: @escaping () -> Right, itemHeight: CGFloat) {
        self.content = content
        self.right = right
        self.itemHeight = itemHeight
    }
    
    @State var hoffset: CGFloat = 0
    @State var anchor: CGFloat = 0
    
    let screenWidth = UIScreen.main.bounds.width
    var anchorWidth: CGFloat { screenWidth / 3 }
    var swipeTreshold:CGFloat { screenWidth / 15 }
    
    @State var rightPast = false
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                withAnimation {
                    hoffset = anchor + value.translation.width
                    
                    if abs(hoffset) > anchorWidth {
                        if rightPast {
                            hoffset = -anchorWidth
                        }
                    }
                    
                    if anchor < 0 {
                        rightPast = hoffset < -anchorWidth + swipeTreshold
                    } else {
                        rightPast = hoffset < -swipeTreshold
                    }
                }
            }
            .onEnded { value in
                withAnimation {
                    if rightPast {
                        anchor = -anchorWidth
                    } else {
                        anchor = 0
                    }
                    hoffset = anchor
                }
            }
    }
    
    
    var body: some View {
        GeometryReader { geo in
            HStack(spacing: 0) {
                content()
                    .frame(width: geo.size.width + 20)
                right()
                    .frame(width: anchorWidth)
                    .zIndex(1)
                    .clipped()
            }
            .offset(x: hoffset)
            .frame(maxHeight: 76)
            .contentShape(Rectangle())
            .gesture(drag)
            .clipped()
        }
    }
}





// 배송정보, 배송이름, 배송상태 구조체
struct PackInfoModel {
    var packageNumber: String
    var packageName: String
    var packageArrvieTime: String
    var packageState: String
}
   
struct SearchTextField: View {
    @State var title: String = ""
    @State private var searchInput = ""
    var body: some View {
        VStack {
            TextField("", text: $searchInput)
        }
        .font(FontManager.body1)
        .frame(height: 52)
        .placeholder(when: searchInput.isEmpty) {
            Text(title)
                .padding(.leading, 20)
                .font(FontManager.body1)
                .foregroundColor(ColorManager.foreground2)
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
        )
        .foregroundColor(ColorManager.background2)
        .padding(.trailing, 20)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
