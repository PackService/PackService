//
//  PackListTabView.swift
//  PackService
//
//  Created by 이범준 on 1/17/23.
//

import SwiftUI

struct PackListTabView: View {
    
    @StateObject var packInfoDatas = PackInfoViewModel()
    var body: some View {
//        VStack {
//            TopOfTabView(title: "배송 목록")
//
//            SearchTextFieldView(title: "검색")
//
//            // 테스트용 버튼
//            Button(action: {
//                test = true
//            }, label: {
//                Text("파이어베이스 연동 테스트")
//            })
//            //
//            List {
//                ForEach(packInfoDatas.packInfoModels) { packInfo in
//                    PackListItemView(packInfoModel: $packInfoDatas.packInfoModels[getIndex(packInfoModel: packInfo)], packInfoModels: $packInfoDatas.packInfoModels)
//                }
//                .background(
//                    ColorManager.background
//                        .cornerRadius(10)
//                        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 2)
//                )
//                .frame(height: 76)
//                Spacer()
//            }
//            .padding(.leading, -17)
//            .listStyle(PlainListStyle())
//            Spacer()
//        }
        HomeView()
    }
    
    func getIndex(packInfoModel: PackInfoModel) -> Int {
        return packInfoDatas.packInfoModels.firstIndex { (packInfoModel1) -> Bool in
            return packInfoModel.id == packInfoModel1.id
        } ?? 0
    }
}

// 기능 구현하면 옮겨야됨
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

struct PackListTabView_Previews: PreviewProvider {
    static var previews: some View {
        PackListTabView()
    }
}
