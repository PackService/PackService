//
//  LoginUIView.swift
//  PackService
//
//  Created by 박윤환 on 2022/12/30.
//

import SwiftUI

struct LoginUIView: View {
    
    enum TextFieldType: Hashable {
        case email
        case password
    }
    
    @State var emailInput: String = ""
    @State var passwordInput: String = ""
    
    @State var isEmailValid: Bool = false
    @State var isPasswordValid: Bool = false
    @State var isSubmitted: Bool = false
    @State var isAnimated: Bool = false
    @FocusState private var focusState: TextFieldType?

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Spacer()
                    
                    VStack(spacing: 16) {                        
                        VStack {
                            InputTextField(title: "이메일", input: $emailInput, isValid: $isEmailValid, isSubmitted: $isSubmitted, isFocused: $focusState)
                                .offset(x: !(isSubmitted && !isEmailValid) || !isAnimated ? 0 : -10)
                                
                            
                            SecureInputTextField(title: "비밀번호", input: $passwordInput, isValid: $isPasswordValid, isSubmitted: $isSubmitted, isFocused: $focusState)
                                .offset(x: !(isSubmitted && !isPasswordValid) || !isAnimated ? 0 : -10)
                        }
                        .onSubmit {
                            toggleFocus()
                        }
                        
                        
                        Button {
                            isSubmitted = true
                            validationCheck()
                            if !(isEmailValid && isPasswordValid) {
                                withAnimation(Animation.spring(response: 0.2, dampingFraction: 0.2, blendDuration: 0.2)) {
                                    isAnimated = true
                                }
                            }
                            isAnimated = false
                        } label: {
                            ButtonView(text: "로그인")
                        }
                        .padding(.top, 40)

                        HStack {
                            Text("계정이 없으신가요?")
                                .foregroundColor(ColorManager.foreground1)
                            
                            Button {
                                
                            } label: {
                                Text("회원가입")
                                    .foregroundColor(ColorManager.primaryColor)
                                    .overlay(
                                        Rectangle()
                                            .frame(height: 1)
                                            .offset(y: 2)
                                            .foregroundColor(ColorManager.primaryColor)
                                        , alignment: .bottom)
                            }
                        }
                        .font(FontManager.body2)

                        Divider()
                            .padding(.vertical, 24)

                        Button {
                            
                        } label: {
                            ThirdPartyButtonView(type: .apple)
                        }
                        
                        Button {
                            
                        } label: {
                            ThirdPartyButtonView(type: .kakao)
                        }
                        
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.vertical, 41)
            }
            .ignoresSafeArea(.keyboard, edges: .all)
        }
        .navigationBarHidden(true)
        
        
    }
    
    func toggleFocus() {
        if focusState == .email {
            focusState = .password
        } else if focusState == .password {
            focusState = nil
        }
    }
    
    func validationCheck() {
        if emailInput == "abc" {
            self.isEmailValid = true
            
            if passwordInput == "1234" {
                self.isPasswordValid = true
                self.focusState = .password
                return
            }
        } else {
            self.isEmailValid = false
            self.focusState = .password
            return
        }
        
//        self.isEmailValid = false
        self.isPasswordValid = false
        self.focusState = .password
        
    }
}

struct InputTextField: View {
    
    @State var title: String = ""
//    @FocusState var isFocused: Bool
    @Binding var input: String
    @Binding var isValid: Bool
    @Binding var isSubmitted: Bool
    var isFocused: FocusState<LoginUIView.TextFieldType?>.Binding
    
    var body: some View {
        TextField("", text: $input)
            .focused(isFocused, equals: .email)
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
                    .strokeBorder(!(isSubmitted && !isValid) ? ColorManager.primaryColor : ColorManager.negativeColor, lineWidth: 2)
                    .opacity(self.isFocused.wrappedValue == .email ? 1.0 : 0.0)
                    .background(self.isFocused.wrappedValue == .email ? ColorManager.background.cornerRadius(10) : ColorManager.background2.cornerRadius(10))
                    .animation(Animation.easeIn(duration: 0.25), value: self.isFocused.wrappedValue == .email)
            )
            
    }
}

struct SecureInputTextField: View {

    @State var title: String = ""
//    @FocusState private var isFocused: Bool
    @Binding var input: String
    @Binding var isValid: Bool
    @Binding var isSubmitted: Bool
    var isFocused: FocusState<LoginUIView.TextFieldType?>.Binding
    
    var body: some View {
        SecureField("", text: $input)
            .focused(isFocused, equals: .password)
            .submitLabel(.return)
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
                    .strokeBorder(!(isSubmitted && !isValid) ? ColorManager.primaryColor : ColorManager.negativeColor, lineWidth: 2)
                    .opacity(isFocused.wrappedValue == .password ? 1.0 : 0.0)
                    .background(isFocused.wrappedValue == .password ? ColorManager.background.cornerRadius(10) : ColorManager.background2.cornerRadius(10))
                    .animation(Animation.easeIn(duration: 0.25), value: isFocused.wrappedValue == .password)
            )
    }
}


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

struct LoginUIView_Previews: PreviewProvider {
    
    @Binding var text: String
    
    static var previews: some View {
        LoginUIView()
    }
}
