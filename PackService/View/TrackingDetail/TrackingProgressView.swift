//
//  TrackingProgressView.swift
//  PackService
//
//  Created by 박윤환 on 2023/01/16.
//

import SwiftUI

//MARK: - TrackingProgressView
struct TrackingProgressView: View {
    @Binding var currentStep: Double
    
    var body: some View {
        ProgressView("Loading...", value: currentStep, total: 3)
            .progressViewStyle(TrackingProgressViewStyle(value: $currentStep))
    }
}

//struct TrackingProgressView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrackingProgressView(currentStep: .constant(2.0))
//    }
//}
