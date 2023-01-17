//
//  PackListItemView.swift
//  PackService
//
//  Created by 이범준 on 1/16/23.
//

import SwiftUI

struct PackListItemView: View {
    @Binding var packInfoModel: PackInfoModel
    @Binding var packInfoModels: [PackInfoModel]
    var body: some View {
        SwipeItemView(content: {
            VStack {
                Button(action: {
                    deletePackInfoModel()
                }, label: {
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
                })
                .buttonStyle(ListButtonStyle())
            }
        }, right: {
            VStack {
                Button(action: {
                    deletePackInfoModel()
                }, label: {
                    ZStack {
                        Rectangle()
                            .fill(.red)
                        HStack {
                            Text("삭제하기")
                                .font(FontManager.body2)
                                .foregroundColor(.white)
                            Image(systemName: "trash.fill")
                                .resizable()
                                .frame(width: 20, height: 24)
                                .foregroundColor(.white)
                        }
                    }
                })
                .buttonStyle(CapsuleButtonStyle())
                .cornerRadius(10)
            }
            .padding(.trailing, 20)
            
        }, itemHeight: 76)
        .listRowSeparator(.hidden)
    }
    
    func deletePackInfoModel() {
        packInfoModels.removeAll { (packInfoModel) -> Bool in
            return self.packInfoModel.id == packInfoModel.id
        }
    }
}

struct ListButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? ColorManager.primaryColor : .clear )
            .cornerRadius(10)
            .padding(.trailing, 20)
    }
}

// 만약 화면에서는 데이터 지워지는데 백 쪽에서 안지워진다면 https://www.youtube.com/watch?v=jXVQDmeNb8A 14분 확인해보기

struct PackListItemView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
