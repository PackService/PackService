//
//  PackListItemView.swift
//  PackService
//
//  Created by 이범준 on 1/16/23.
//

import SwiftUI

struct ListRowCellView: View {
    @Binding var item: ShowModel
    @Binding var items: [ShowModel]
    @EnvironmentObject var vm: MainViewModel
    
    @State var offset: CGFloat = 0
    @State var isSwiped: Bool = false
    @GestureState var isDragging = false

    var body: some View {
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(ColorManager.negativeColor)
                    .frame(height: 75)
                    .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 2)
                
                HStack {
                    Spacer()
                    
                    Button {
                        withAnimation(.easeIn) {
                            deleteModel()
                        }
                    } label: {
                        HStack(spacing: 8) {
                            Text("삭제하기")
                            
                            Image(systemName: "trash.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                        }
                        .font(FontManager.body2)
                        .foregroundColor(ColorManager.background)
                        .padding(.horizontal, 20)
                    }
                    .frame(height: 75)
                }
            }
            
            NavigationLink {
                TrackingDetailLoadingView(company: item.company, invoice: item.invoice, item: item.name)
            } label: {
                itemCell
                    .contentShape(RoundedRectangle(cornerRadius: 10))
                    .offset(x: offset)
                    .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnd(value:)))
            }
            .buttonStyle(ListRowButtonStyle(isSwiped: $isSwiped, offset: $offset))
            
            //Swiped motion logic
            if isSwiped {
                RoundedRectangle(cornerRadius: 10)
                    .fill(ColorManager.background.opacity(0.0))
                    .contentShape(RoundedRectangle(cornerRadius: 10))
                    .frame(height: 75)
                    .offset(x: offset)
                    .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnd(value:)))
                    .onTapGesture {
                        withAnimation(.easeOut) {
                            isSwiped = false
                            offset = 0
                        }
                    }
            }
            
        }
    }
    
    //MARK: - onChanged(value:)
    func onChanged(value: DragGesture.Value) {
        if value.translation.width < 0 {
            if isSwiped {
                offset = value.translation.width - 120
            } else {
                offset = value.translation.width
            }
        } else {
            if isSwiped {
                offset = min(0, value.translation.width - 120)
            }
        }
    }
    
    //MARK: - onEnd(value:)
    func onEnd(value: DragGesture.Value) {
        withAnimation(.easeOut) {
            if value.translation.width < 0 {
                if -value.translation.width > UIScreen.main.bounds.width / 2.5 {
                    offset = -1000
                    deleteModel()
                } else if -offset > 50 {
                    isSwiped = true
                    offset = -120
                } else {
                    isSwiped = false
                    offset = 0                    
                }
            } else {
                isSwiped = false
                offset = 0
            }
        }
    }
    
    //MARK: - deleteModel()
    func deleteModel() {
        print("INVOICE", self.item.invoice)
        print("COMPANY", self.item.company)
        vm.service.deleteTrackNumber(company: self.item.company, invoice: self.item.invoice)
        items.removeAll { (model1) -> Bool in
            vm.trackingModels.removeAll { (model2) -> Bool in
                return self.item.id == model2.id
            }
            return self.item.id == model1.id
        }
        
    }
}

extension ListRowCellView {
    var itemCell: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(item.isComplete ? ColorManager.background : ColorManager.secondaryColor)
                .frame(height: 76)
            
            HStack(spacing: 16) {
                Circle()
                    .fill(ColorManager.defaultForegroundDisabled)
                    .frame(width: 44, height: 44)
                    .overlay(
                        LogoType(rawValue: item.company)?.logo.image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height: 44)
                )
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(item.name)
                        .lineLimit(1)
                        .font(FontManager.title2)
                        .frame(maxWidth: 233, alignment: .leading)
                    
                    HStack {
                        Text(item.invoice)
                        Spacer()
                        HStack(spacing: 8) {
                            Text(item.time)
                            Text(TrackingStatus(rawValue: Int(item.currentStep))?.status ?? "배송전")
                                .font(FontManager.caption2)
                                .foregroundColor(ColorManager.primaryColor)
                        }
                        
                    }
                    .font(FontManager.caption1)
                    .foregroundColor(ColorManager.foreground1)
                    
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

// 만약 화면에서는 데이터 지워지는데 백 쪽에서 안지워진다면 https://www.youtube.com/watch?v=jXVQDmeNb8A 14분 확인해보기

//struct PackListItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            PackListItemView(item: .constant(PackInfoModel(packageNumber: "1111111111", packageName: "유세린 더머토 클린 리프레싱 클렌징젤 200ml 1+1", packageArrvieTime: "12:48", packageState: "간선상차", isComplete: false)), items: .constant([]))
//                .previewLayout(.sizeThatFits)
//
////            PackListItemView(item: .constant(PackInfoModel(packageNumber: "1111111111", packageName: "유세린 더머토 클린 리프레싱 클렌징젤 200ml 1+1", packageArrvieTime: "12:48", packageState: "배송완료", isComplete: true)))
////                .previewLayout(.sizeThatFits)
//        }
//    }
//}


//SwipeItemView(content: {
//    VStack {
//        Button(action: {
//
//        }, label: {
//            HStack {
//                Spacer()
//                VStack {
//                    HStack {
//                        Image(systemName: "circle.fill")
//                            .resizable()
//                            .frame(width: 44, height: 44)
//                        VStack(alignment: .leading) {
//                            Text(packInfoModel.packageName)
//                                .font(FontManager.title3)
//                                .padding(.bottom, 2)
//                            HStack {
//                                Text(packInfoModel.packageNumber)
//                                    .font(FontManager.caption1)
//                                    .foregroundColor(ColorManager.foreground1)
//                                Spacer()
//                                Text(packInfoModel.packageArrvieTime)
//                                    .font(FontManager.caption1)
//                                    .foregroundColor(ColorManager.foreground1)
//                                    .padding(.trailing, 8)
//                                Text(packInfoModel.packageState)
//                                    .font(FontManager.caption2)
//                                    .foregroundColor(ColorManager.primaryColor)
//                            }
//                        }
//                        .padding(.leading, 16)
//                        Spacer()
//                    }
//                    .padding(16)
//                }
//                Spacer()
//            }
//        })
//        .buttonStyle(ListButtonStyle())
//    }
//}, right: {
//    VStack {
//        Button(action: {
////                    deletePackInfoModel()
//        }, label: {
//            ZStack {
//                Rectangle()
//                    .fill(.red)
//                HStack {
//                    Text("삭제하기")
//                        .font(FontManager.body2)
//                        .foregroundColor(.white)
//                    Image(systemName: "trash.fill")
//                        .resizable()
//                        .frame(width: 20, height: 24)
//                        .foregroundColor(.white)
//                }
//            }
//        })
//        .buttonStyle(ContainerButtonStyle())
//        .cornerRadius(10)
//    }
//    .padding(.trailing, 20)
//
//}, itemHeight: 76)
//.listRowSeparator(.hidden)
