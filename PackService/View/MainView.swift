//
//  MainView.swift
//  PackService
//
//  Created by 이범준 on 1/4/23.
//

import SwiftUI

// MARK: - MainView
struct MainView: View {
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
            Text("search")
                .padding(.trailing, 20)
                .padding(.bottom, 16)
            
            List {
                ForEach(packInfoModel, id: \.packageNumber) { packInfo in
                    // 배송 진행중인 목록 보여주는 곳
                    CurrentPackageCell(packInfoModel: packInfo)
                }
                .onDelete(perform: removeRows)
            }
            .listStyle(InsetListStyle()) // 스타일 수정 필요
            .padding(.trailing, 20)
            
            Spacer()
        }
    }
    
    func removeRows(at offsets: IndexSet) {
      packInfoModel.remove(atOffsets: offsets)
    }
}

// 배송정보, 배송이름, 배송상태 구조체
struct PackInfoModel {
    var packageNumber: String
    var packageName: String
    var packageArrvieTime: String
    var packageState: String
}

struct CurrentPackageCell: View {
    var packInfoModel: PackInfoModel
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                HStack {
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: 44, height: 44)
                    VStack(alignment: .leading) {
                        Text(packInfoModel.packageName)
                            .font(FontManager.title3)
                            .padding(.bottom, 2)
                        HStack {
                            Text(packInfoModel.packageNumber)
                                .font(FontManager.caption1)
                                .foregroundColor(ColorManager.foreground1)
                            Spacer()
                            Text(packInfoModel.packageArrvieTime)
                                .font(FontManager.caption1)
                                .foregroundColor(ColorManager.foreground1)
                                .padding(.trailing, 8)
                            Text(packInfoModel.packageState)
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
        .background(
            ColorManager.background
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 2)
        )
        .padding(8)
        .frame(height: 76)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
