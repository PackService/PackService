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
                            PackListItemView(item: $vm.searchModels[getIndex(model: item)], items: $vm.searchModels)
                                .environmentObject(vm)
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

// 기능 구현하면 옮겨야됨
struct PackInfoModel: Identifiable {
    let id = UUID().uuidString
    var packageNumber: String
    var packageName: String
    var packageArrvieTime: String
    var packageState: String
    var isComplete: Bool
}

class PackInfoViewModel: ObservableObject {
    @Published var searchText = ""
    
    @Published var models1 = [
        PackInfoModel(packageNumber: "123432", packageName: "1번이요", packageArrvieTime: "23:34", packageState: "배송중", isComplete: false),
        PackInfoModel(packageNumber: "122332", packageName: "2번이요", packageArrvieTime: "23:34", packageState: "배송중", isComplete: false),
        PackInfoModel(packageNumber: "167732", packageName: "3번이요", packageArrvieTime: "23:34", packageState: "배송완료", isComplete: true),
        PackInfoModel(packageNumber: "88832", packageName: "4번이요", packageArrvieTime: "23:34", packageState: "배송완료", isComplete: true),
        PackInfoModel(packageNumber: "773432", packageName: "1번이요", packageArrvieTime: "23:34", packageState: "배송완료", isComplete: true)
    ]
    
    @Published var searchModels: [PackInfoModel] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        filteredModel()
    }
    
    func filteredModel() {
        $searchText
            .combineLatest($models1)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filtering)
            .sink { [weak self] (models) in
                self?.searchModels = models
            }
            .store(in: &cancellables)
    }
    
    private func filtering(text: String, models: [PackInfoModel]) -> [PackInfoModel] {
        guard !text.isEmpty else { return models }
        
        let lowercasedText = text.lowercased()
        
        return models.filter { model in
            return model.packageNumber.lowercased().contains(lowercasedText) ||
            model.packageName.lowercased().contains(lowercasedText)
        }
    }
}

struct PackListTabView_Previews: PreviewProvider {
    static var previews: some View {
        PackListTabView()
    }
}
