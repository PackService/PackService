//
//  TrackingProgressView2.swift
//  PackService
//
//  Created by 이범준 on 1/19/23.
//

import SwiftUI

//MARK: - TrackingStatusView
struct TrackingStatusView: View {
    var currentStep: Double
    
    var body: some View {
        ProgressView("Loading...", value: currentStep, total: 3)
            .progressViewStyle(TrackingStatusViewStyle(value: currentStep))
    }
}

//struct TrackingProgressView2_Previews: PreviewProvider {
//    static var previews: some View {
//        TrackingProgressView2(currentStep: .constant(0.0))
//    }
//}
