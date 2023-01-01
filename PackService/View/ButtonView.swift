//
//  ButtonView.swift
//  PackService
//
//  Created by 박윤환 on 2022/12/30.
//

import SwiftUI

struct ButtonView: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(ColorManager.background)
            .font(FontManager.title2)
            .frame(maxWidth: .infinity)
            .frame(height: 58)
            .background(ColorManager.primaryColor.cornerRadius(29))
    }
}
struct DisabledButtonView: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(ColorManager.background)
            .font(FontManager.title2)
            .frame(maxWidth: .infinity)
            .frame(height: 58)
            .background(ColorManager.defaultForegroundDisabled.cornerRadius(29))
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(text: "Example")
            .previewLayout(.sizeThatFits)
    }
}
