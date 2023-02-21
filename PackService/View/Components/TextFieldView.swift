//
//  TextFieldView.swift
//  PackService
//
//  Created by 박윤환 on 2023/01/09.
//

import SwiftUI

//MARK: - TextFieldView
struct TextFieldView: View {
    
    @State var title: String = ""
    
    @Binding var input: String
    @Binding var wrongAttempt: Bool
    @Binding var animationTrigger: Bool
    var isFocused: FocusState<TextFieldType?>.Binding
    
    var type: TextFieldType
    var isSecure: Bool = false
    
    var body: some View {
        ZStack {
            Group {
                if isSecure {
                    SecureField("", text: $input)
                } else {
                    TextField("", text: $input)
                }
            }
                .focused(isFocused, equals: type)
                .font(FontManager.body1)
                .foregroundColor(ColorManager.defaultForeground)
                .tint(ColorManager.primaryColor)
                .padding(.horizontal, 20)
                .padding(.vertical, 18)
                .placeholder(when: input.isEmpty) {
                    Text(title)
                        .padding(.leading, 20)
                        .font(FontManager.body1)
                        .foregroundColor(ColorManager.foreground2)
                }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(!wrongAttempt ? ColorManager.primaryColor : ColorManager.negativeColor, lineWidth: 2)
                        .opacity(isFocused.wrappedValue == type ? 1.0 : 0.0)
                        .background(isFocused.wrappedValue == type ? ColorManager.background.cornerRadius(10) : ColorManager.background2.cornerRadius(10))
                        .animation(Animation.easeIn(duration: 0.25), value: isFocused.wrappedValue == type)
            )
        }
        .offset(x: !wrongAttempt || !animationTrigger ? 0 : -10)
    }
}

enum TextFieldType: Hashable {
    case email
    case password
    case passwordConfirm
    case trackingNumber
}
