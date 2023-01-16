//
//  TrackingProgressView.swift
//  PackService
//
//  Created by 박윤환 on 2023/01/16.
//

import SwiftUI

//MARK: - ProgressView
struct TrackingProgressView: View {
    @Binding var currentStep: Double
    
    var body: some View {
        ProgressView("Loading...", value: currentStep, total: 3)
            .progressViewStyle(TrackingProgressViewStyle(value: $currentStep))
    }
}

//MARK: - ProgressView Style
struct TrackingProgressViewStyle: ProgressViewStyle {
    @Binding var value: Double
    
    func makeBody(configuration: Configuration) -> some View {
        
        return GeometryReader { geometry in
            let offset = geometry.size.width / 3 * value
            
            VStack {
                ZStack(alignment: .leading) {
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 32)
                            .fill(ColorManager.background2)
                            .frame(width: geometry.size.width, height: 32)

                        RoundedRectangle(cornerRadius: 32)
                            .frame(width: value == 0 ? 40 : CGFloat(configuration.fractionCompleted ?? 0) * geometry.size.width, height: 32)
                            .foregroundColor(ColorManager.primaryColor)
                    }
                    
                    RoundedRectangle(cornerRadius: 32)
                        .fill(ColorManager.primaryColor)
                        .frame(width: 40, height: 32)
                        .overlay(
                            Image(systemName: "box.truck.fill")
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18, height: 18)
                                .foregroundColor(ColorManager.background)
                        )
                        .offset(x: value != 3 ? (offset - (value == 0 ? 0 : 30)) : geometry.size.width - 40)
                }
            }
        }
        
    }

}

struct TrackingProgressView_Previews: PreviewProvider {
    static var previews: some View {
        TrackingProgressView(currentStep: .constant(2.0))
    }
}
