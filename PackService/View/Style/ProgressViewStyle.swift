//
//  ProgressViewStyle.swift
//  PackService
//
//  Created by 박윤환 on 2023/02/20.
//

import Foundation
import SwiftUI

//MARK: - TrackingStatusViewStyle
struct TrackingStatusViewStyle: ProgressViewStyle {
    var value: Double
    
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
                            .frame(width: value == 0 ? 0 : CGFloat(configuration.fractionCompleted ?? 0) * geometry.size.width, height: 8)
                            .foregroundColor(ColorManager.primaryColor)
                    }
                    .padding(.top, -13)
                    
                    HStack {
                        VStack(spacing: 4) {
                            Circle()
                                .fill(ColorManager.primaryColor)
                                .frame(width: 32, height: 32)
                                .overlay(
                                    Image(systemName: "list.clipboard.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 16, height: 16)
                                        .foregroundColor(ColorManager.background)
                            )
                            
                            Text("입고")
                                .font(FontManager.caption1)
                                .foregroundColor(ColorManager.foreground1)
                        }

                        Spacer()
                        
                        VStack(spacing: 4) {
                            Circle()
                                .fill(value >= 1 ? ColorManager.primaryColor : ColorManager.background2)
                                .frame(width: 32, height: 32)
                                .overlay(
                                    Image(systemName: "shippingbox.fill")
                                        .foregroundColor(value >= 1 ? ColorManager.background : ColorManager.foreground2)
                                )
                            
                            Text("출고")
                                .font(FontManager.caption1)
                                .foregroundColor(ColorManager.foreground1)
                        }
                        
                        Spacer()
                        
                        VStack(spacing: 4) {
                            Circle()
                                .fill(value >= 2 ? ColorManager.primaryColor : ColorManager.background2)
                                .frame(width: 32, height: 32)
                                .overlay(
                                    Image(systemName: "box.truck.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 18, height: 18)
                                        .foregroundColor(value >= 2 ? ColorManager.background : ColorManager.foreground2)
                            )
                            
                            Text("배송")
                                .font(FontManager.caption1)
                                .foregroundColor(ColorManager.foreground1)
                        }
                        
                        Spacer()
                        
                        VStack(spacing: 4) {
                            Circle()
                                .fill(value >= 3 ? ColorManager.primaryColor : ColorManager.background2)
                                .frame(width: 32, height: 32)
                                .overlay(
                                    Image(systemName: "house.fill")
                                        .foregroundColor(value >= 3 ? ColorManager.background : ColorManager.foreground2)
                            )
                            
                            Text("도착")
                                .font(FontManager.caption1)
                                .foregroundColor(ColorManager.foreground1)
                        }
                    }
  
                }
            }
        }
        
        
    }
}

//MARK: - TrackingProgressViewStyle
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
