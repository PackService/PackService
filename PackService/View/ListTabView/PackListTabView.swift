//
//  PackListTabView.swift
//  PackService
//
//  Created by 이범준 on 1/17/23.
//

import SwiftUI
import Combine

struct PackListTabView: View {
    
    @EnvironmentObject var vm: MainViewModel
//    @StateObject var packInfoDatas = PackInfoViewModel()
    @FocusState var isFocused: Bool
    
    var body: some View {
        //NavigationView?
        VStack {
            TopOfTabView(title: "배송 목록")
                .contentShape(Rectangle())
                .onTapGesture {
                    isFocused = false
                }

            SearchTextFieldView(title: "검색", searchInput: $vm.searchText, isFocused: $isFocused)

            ScrollView {
                LazyVStack {
                    if !vm.searchModels.isEmpty {
                        ForEach(vm.searchModels.reversed()) { item in
                            NavigationLink {
                                TrackingDetailLoadingView(companyId: item.company, invoiceNumber: item.invoice, item: item.name)
                            } label: {
                                PackListItemView(item: $vm.searchModels[getIndex(model: item)], items: $vm.searchModels)
                                    .environmentObject(vm)
                            }
                            .buttonStyle(ContainerButtonStyle())
                        }
                    } else if vm.searchModels.isEmpty && !vm.searchText.isEmpty {
                        ZStack {
                            Rectangle()
                                .fill(ColorManager.background)
                            
                            Text("검색 결과가 없습니다")
                                .font(FontManager.title2)
                                .foregroundColor(ColorManager.foreground2)
                        }
                    } else {
                        ZStack {
                            Rectangle()
                                .fill(ColorManager.background)
                            
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
                    }
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
            }
            .padding(.horizontal, -20)
            .onTapGesture {
                isFocused = false
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
        
//        HomeView()
    }
    
    func getIndex(model: InfoModel) -> Int {
        return vm.searchModels.firstIndex { (returnedModel) -> Bool in
            return model.id == returnedModel.id
        } ?? 0
    }
}

struct PackListTabView_Previews: PreviewProvider {
    static var previews: some View {
        PackListTabView()
    }
}
