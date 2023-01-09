//
//  TextFieldView.swift
//  PackService
//
//  Created by 박윤환 on 2023/01/09.
//

import SwiftUI

struct TextFieldView: View {
    
    @State var title: String = ""
    @Binding var input: String
    @Binding var wrongAttempt: Bool
    var isFocused: FocusState<TextFieldType?>.Binding
    @Binding var animationTrigger: Bool
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
                .submitLabel(.next)
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

extension View {
    func placeholder<Content: View>(
            when shouldShow: Bool,
            alignment: Alignment = .leading,
            @ViewBuilder placeholder: () -> Content) -> some View {

            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}


//struct SecuredTextField: View {
//
//    @State var title: String = ""
//    @Binding var input: String
//    @Binding var wrongAttempt: Bool
//    var isFocused: FocusState<LoginUIView.TextFieldType?>.Binding
//    @Binding var animationTrigger: Bool
//
//    var body: some View {
//        ZStack {
//            SecureField("", text: $input)
//                .focused(isFocused, equals: .password)
//                .submitLabel(.return)
//                .font(FontManager.body1)
//                .foregroundColor(ColorManager.defaultForeground)
//                .tint(ColorManager.primaryColor)
//                .padding(.horizontal, 20)
//                .padding(.vertical, 18)
//                .placeholder(when: input.isEmpty) {
//                    Text(title)
//                        .padding(.leading, 20)
//                        .font(FontManager.body1)
//                        .foregroundColor(ColorManager.foreground2)
//                }
//                .background(
//                    RoundedRectangle(cornerRadius: 10)
//                        .strokeBorder(!wrongAttempt ? ColorManager.primaryColor : ColorManager.negativeColor, lineWidth: 2)
//                        .opacity(isFocused.wrappedValue == .password ? 1.0 : 0.0)
//                        .background(isFocused.wrappedValue == .password ? ColorManager.background.cornerRadius(10) : ColorManager.background2.cornerRadius(10))
//                        .animation(Animation.easeIn(duration: 0.25), value: isFocused.wrappedValue == .password)
//            )
//        }
//        .offset(x: !wrongAttempt || !animationTrigger ? 0 : -10)
//    }
//}


//struct InvalidTextFieldInputModifier: ViewModifier {
//
//    var isButtonClicked: Bool
//    var isValid: Bool
//
//    func body(content: Content) -> some View {
//        if isButtonClicked {
//            content
//                .background(
//                    RoundedRectangle(cornerRadius: 10)
//                        .stroke(ColorManager.negativeColor, lineWidth: 2)
//                        .background(ColorManager.background.cornerRadius(10))
//                        .offset(x: isValid ? -5 : 0)
//                        .animation(Animation.default.repeatCount(3).speed(3), value: isValid)
//                )
//        }
//
//    }
//}
