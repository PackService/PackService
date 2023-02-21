//
//  ButtonStyle.swift
//  PackService
//
//  Created by 박윤환 on 2023/02/20.
//

import Foundation
import SwiftUI

//MARK: - CarouselButtonStyle
struct CarouselButtonStyle: ButtonStyle {
    @Binding var isDragging: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .brightness(configuration.isPressed && !isDragging ? -0.05 : 0.0)
    }
}

//MARK: - InsightButtonStyle
struct InsightButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(Circle().fill(isEnabled ? ColorManager.primaryColor : ColorManager.defaultForegroundDisabled))
            .brightness(configuration.isPressed ? -0.05 : 0.0)
    }
}

//MARK: - ListRowButtonStyle
struct ListRowButtonStyle: ButtonStyle {
    @Binding var isSwiped: Bool
    @Binding var offset: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .brightness(configuration.isPressed && !isSwiped ? -0.1 : 0.0)
    }
}

//MARK: - ContainerButtonStyle
struct ContainerButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .brightness(configuration.isPressed ? -0.1 : 0.0)
    }
}

//struct NormalButtonStyle: ButtonStyle {
//    @Environment(\.isEnabled) var isEnabled: Bool
//    
//    func makeBody(configuration: Self.Configuration) -> some View {
//        configuration.label
//            .frame(width: 350, height: 60)
//            .font(.custom("Pretendard", size: 15))
//            .foregroundColor(.white)
//            .background(ColorManager.primaryColor)
//            .cornerRadius(50.0)
//    }
//}
