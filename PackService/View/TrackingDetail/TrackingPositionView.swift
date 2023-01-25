//
//  TrackingPositionView.swift
//  PackService
//
//  Created by 박윤환 on 2023/01/16.
//

import SwiftUI

struct TrackingPositionView: View {
    @EnvironmentObject var trackingDetailVM: TrackingInfoViewModel
    
    var code: String
    var invoice: String
    
    @State var step: Double = 0
    @State var showList: Bool = false
    @Environment(\.defaultMinListRowHeight) var minRowHeight

    init(code: String, invoice: String) {
        self.code = code
        self.invoice = invoice
    }
    
    var body: some View {
        
        VStack(spacing: 8) {
            HStack {
                Text("택배 위치")
                    .font(FontManager.title1)
                
                Spacer()

                Button {
                    step = 0.0
                    trackingDetailVM.reloadData(code: self.code, invoice: self.invoice)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        step = trackingDetailVM.currentStep
                    }
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
                        Text("\(trackingDetailVM.currentStep)")
                        
                        TrackingProgressView(currentStep: $step)
                            .frame(height: 32)
                            .padding(.top, 24)
                            .padding(.horizontal, 12)
                            .animation(Animation.easeIn(duration: 1.0), value: step)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                    step = trackingDetailVM.currentStep
                                }
                            }
                    
                        let arr = ["출발", "이동중", "배송출발", "도착"]
                        
                        HStack {
                            ForEach(Array(arr.enumerated()), id: \.offset) { index, item in
                                Text(item)
                                    .font(FontManager.caption1)
                                    .foregroundColor(index != Int(trackingDetailVM.currentStep) ? ColorManager.foreground1 : ColorManager.primaryColor)
                                
                                if item != "도착" {
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
        TrackingPositionView(code: "04", invoice: "1111111111")
    }
}
