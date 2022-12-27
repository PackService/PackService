//
//  TrackingInfoView.swift
//  PackService
//
//  Created by 박윤환 on 2022/12/26.
//

import SwiftUI

struct TrackingInfoLoadingView: View {
    @Binding var companyId: String
    @Binding var invoiceNumber: String
    
    var body: some View {
        TrackingInfoView(companyId: companyId, invoiceNumber: invoiceNumber)
    }
    
}

struct TrackingInfoView: View {
    
    @StateObject private var trackingInfoVM: TrackingInfoService
    
    init(companyId: String, invoiceNumber: String) {
        _trackingInfoVM = StateObject(wrappedValue: TrackingInfoService(companyId, invoiceNumber))
    }
    
    var body: some View {
        VStack(spacing: 20) {
//            Text(trackingInfoVM.trackingInfo.complete)
            if let trackingInfo = trackingInfoVM.trackingInfo {
                HStack {
                    Text("배송 완료 여부 : ")
                    Spacer()
                    Text(trackingInfo.complete ? "Y" : "N")
                }
                .padding(.horizontal, 20)
                
                HStack {
                    Text("운송장 번호 : ")
                    Spacer()
                    Text(trackingInfo.invoiceNo)
                }
                .padding(.horizontal, 20)
                
                
                
                List {
                    ForEach(trackingInfo.trackingDetails) { detail in
                        VStack(alignment: .leading, spacing: 5) {
                            Text("\(detail.level)")
                            Text("\(detail.kind)")
                                .bold()
                        }
                    }
                }                
            } else {
                Text("입력된 운송장 번호와 일치하는 정보를 찾을 수 없습니다.")
            }
            
        }
        
    }
}

struct TrackingInfoView_Previews: PreviewProvider {

    static let companyIdPreview = "04"
    static let invoiceNumberPreview = "1111111111"

    static var previews: some View {
        TrackingInfoView(companyId: companyIdPreview, invoiceNumber: invoiceNumberPreview)
    }
}
