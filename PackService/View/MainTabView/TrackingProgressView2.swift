//
//  TrackingProgressView2.swift
//  PackService
//
//  Created by 이범준 on 1/19/23.
//

import SwiftUI

struct TrackingProgressView2: View {
    @Binding var currentStep: Double
    
    var body: some View {
        ProgressView("Loading...", value: currentStep, total: 3)
            .progressViewStyle(TrackingProgressViewStyle2(value: $currentStep))
    }
}

//MARK: - ProgressView Style
struct TrackingProgressViewStyle2: ProgressViewStyle {
    @Binding var value: Double
    
    func makeBody(configuration: Configuration) -> some View {
        
        return GeometryReader { geometry in
            let offset = geometry.size.width / 3 * value
            
            VStack {
                ZStack(alignment: .leading) {
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 32)
                            .fill(ColorManager.background2)
                            .frame(width: geometry.size.width, height: 8)
                        RoundedRectangle(cornerRadius: 32)
                            .frame(width: value == 0 ? 40 : CGFloat(configuration.fractionCompleted ?? 0) * geometry.size.width, height: 8)
                            .foregroundColor(ColorManager.primaryColor)
                        Image(systemName: "shippingbox.circle.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundColor(ColorManager.primaryColor)
                            .background(ColorManager.background)
                            .clipShape(Circle())
                        Image(systemName: "house.circle.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundColor(ColorManager.background2)
                            .background(ColorManager.foreground2)
                            .clipShape(Circle())
                            .padding(.leading, geometry.size.width - 32)
                    }
                    
                    Circle()
                        .fill(ColorManager.primaryColor)
                        .frame(width: 32, height: 32)
                        .overlay(
                            Image(systemName: "box.truck.fill")
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18, height: 18)
                                .foregroundColor(ColorManager.background)
                        )
                        .offset(x: value != 3 ? (offset - (value == 0 ? 0 : 30)) : geometry.size.width - 32)
                }
            }
        }
        
    }

}


struct TrackingProgressView2_Previews: PreviewProvider {
    static var previews: some View {
        TrackingProgressView2(currentStep: .constant(2.0))
    }
}
