//
//  TrackingPositionView.swift
//  PackService
//
//  Created by 박윤환 on 2023/01/16.
//

import SwiftUI

struct TrackingPositionView: View {
    @EnvironmentObject var trackingDetailVM: TrackingInfoViewModel
    
    @State var step: Double = 1
    @State var showList: Bool = false
//    @State var listSize: CGSize = .zero
    @Environment(\.defaultMinListRowHeight) var minRowHeight

    
    var body: some View {
        
        VStack(spacing: 8) {
            HStack {
                Text("택배 위치")
                    .font(FontManager.title1)
                
                Spacer()
                
                Button {
                    step += 1
                } label: {
                    Image(systemName: "arrow.clockwise.circle.fill")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(ColorManager.primaryColor)
                }
            }
        
            ZStack {
                ColorManager.background
                    .cornerRadius(10)
//                    .frame(width: 350, height: 152)
                    .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 2)
                    
                
                VStack {
                    Group {
                        TrackingProgressView(currentStep: $step)
                            .frame(height: 32)
                            .padding(.top, 24)
                            .padding(.horizontal, 12)
                            .animation(Animation.easeIn(duration: 1.0), value: step)
                            .onAppear {
                                step = 0
                            }
                    
                        HStack {
                            ForEach(Array(zip(trackingDetailVM.positions.indices, trackingDetailVM.positions)), id: \.0) { index, item in
                                Text(item ?? "(정보없음)")
                                    .font(FontManager.caption1)
                                    .foregroundColor(item != trackingDetailVM.positions[Int(step)] ? ColorManager.foreground1 : ColorManager.primaryColor)
        //                        Text((dict[key] ?? "(정보없음)") ?? "(정보없음)")
                                if index != (trackingDetailVM.positions.count - 1) {
                                    Spacer()
                                }
                                
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 8)
                    }
//                    .background(Color.yellow)
                    
                    Spacer()
                    
                    //MARK: - List
                    if showList {
                        VStack {
                            ForEach(trackingDetailVM.trackingDetails) { detail in
                                TrackingPositionListCellView(
                                    status: detail.kind,
                                    position: detail.detailWhere,
                                    deliveryMan: detail.manName,
                                    time: detail.timeAndDateTuple.time,
                                    date: detail.timeAndDateTuple.date,
                                    isCurrent: detail.id == trackingDetailVM.trackingDetails.last!.id)
                                    .padding(.vertical, 8)
                            }
                        }
                        .padding(.vertical, 16)
                        .padding(.horizontal, 16)
                    }
                    
                    Button {
                        showList.toggle()
                    } label: {
                        HStack {
                            Text(showList ? "간략히 보기" : "자세히 보기")
                                .font(FontManager.body2)
                            
                            Image(systemName: showList ? "chevron.up" : "chevron.down")
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .foregroundColor(ColorManager.foreground2)
                    }
                    .overlay (
                        Rectangle()
                            .fill(ColorManager.background2)
                            .frame(height: 2)
                        , alignment: .top
                    )

                }
                
            }
        }
        
    }
}

struct TrackingPositionView_Previews: PreviewProvider {
    static var previews: some View {
        TrackingPositionView()
    }
}
