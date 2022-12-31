//
//  ButtonStyle.swift
//  PackService
//
//  Created by 이범준 on 12/30/22.
//

import Foundation
import SwiftUI

struct NormalButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 350, height: 60)
            .font(.custom("Pretendard", size: 15))
            .foregroundColor(.white)
            .background(ColorManager.primaryColor)
            .cornerRadius(50.0)
    }
}

