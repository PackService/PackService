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
    
    @State var serviceAgreeScreen: Bool = false
    @StateObject var packInfoDatas = PackInfoViewModel()
    
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
                ForEach(packInfoDatas.packInfoModels) { packInfo in
                    // 배송 진행중인 목록 보여주는 곳
                    PackListItemView(packInfoModel: $packInfoDatas.packInfoModels[getIndex(packInfoModel: packInfo)], packInfoModels: $packInfoDatas.packInfoModels)
                } // packinfo 끝
                
                .background(
                    ColorManager.background
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 2)
                )
                .frame(height: 76)
                Spacer()
            }
            .padding(.leading, -17)
            .listStyle(PlainListStyle())
            
            Spacer()
        }
    }
    
    func getIndex(packInfoModel: PackInfoModel) -> Int {
        
        return packInfoDatas.packInfoModels.firstIndex { (packInfoModel1) -> Bool in
            return packInfoModel.id == packInfoModel1.id
        } ?? 0
    }
}


// 배송정보, 배송이름, 배송상태 구조체
struct PackInfoModel: Identifiable {
    var id = UUID().uuidString
    var packageNumber: String
    var packageName: String
    var packageArrvieTime: String
    var packageState: String
}

class PackInfoViewModel: ObservableObject {
    @Published var packInfoModels = [
        PackInfoModel(packageNumber: "123432", packageName: "1번이요", packageArrvieTime: "23:34", packageState: "배송중"),
        PackInfoModel(packageNumber: "122332", packageName: "2번이요", packageArrvieTime: "23:34", packageState: "배송중"),
        PackInfoModel(packageNumber: "167732", packageName: "3번이요", packageArrvieTime: "23:34", packageState: "배송중"),
        PackInfoModel(packageNumber: "88832", packageName: "4번이요", packageArrvieTime: "23:34", packageState: "배송중"),
        PackInfoModel(packageNumber: "773432", packageName: "1번이요", packageArrvieTime: "23:34", packageState: "배송중")
    ]
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
