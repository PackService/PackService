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
    
    @State var isEmailValid: Bool = true
    @State var isPasswordValid: Bool = true
    
    @State var isSubmitted: Bool = false
    
    @State var emailAttempt: Bool = false
    @State var passwordAttempt: Bool = false
    
    @State var animationTrigger: Bool = false
    @FocusState private var focusState: TextFieldType?

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Spacer()
                    
                    VStack(spacing: 16) {
                        VStack {
                            DefaultTextField(title: "이메일", input: $emailInput, wrongAttempt: $emailAttempt, isFocused: $focusState, animationTrigger: $animationTrigger)
                            
                            SecuredTextField(title: "비밀번호", input: $passwordInput, wrongAttempt: $passwordAttempt, isFocused: $focusState, animationTrigger: $animationTrigger)
                        }
                        .onSubmit {
                            toggleFocus()
                        }
                        
                        Button {
                            isSubmitted = true
                            validationCheck()
                            
                            emailAttempt = (isSubmitted && !isEmailValid)
                            passwordAttempt = (isSubmitted && !isPasswordValid)
                            
                            if !(isEmailValid && isPasswordValid) {
                                withAnimation(Animation.spring(response: 0.2, dampingFraction: 0.2, blendDuration: 0.2)) {
                                    animationTrigger = true
                                }
                            }
                            
                            animationTrigger = false
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
        } else if emailInput != "abc" && passwordInput.isEmpty {
            self.isEmailValid = false
            self.focusState = .email
            return
        } else {
            self.isEmailValid = false
        }
        
//        self.isEmailValid = false
        self.isPasswordValid = false
        self.focusState = .password
        
    }
}

struct DefaultTextField: View {
    
    @State var title: String = ""
    @Binding var input: String
    @Binding var wrongAttempt: Bool
    var isFocused: FocusState<LoginUIView.TextFieldType?>.Binding
    @Binding var animationTrigger: Bool
    
    var body: some View {
        ZStack {
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
                        .strokeBorder(!wrongAttempt ? ColorManager.primaryColor : ColorManager.negativeColor, lineWidth: 2)
                        .opacity(isFocused.wrappedValue == .email ? 1.0 : 0.0)
                        .background(isFocused.wrappedValue == .email ? ColorManager.background.cornerRadius(10) : ColorManager.background2.cornerRadius(10))
                        .animation(Animation.easeIn(duration: 0.25), value: isFocused.wrappedValue == .email)
            )
        }
        .offset(x: !wrongAttempt || !animationTrigger ? 0 : -10)
    }
}

struct SecuredTextField: View {

    @State var title: String = ""
    @Binding var input: String
    @Binding var wrongAttempt: Bool
    var isFocused: FocusState<LoginUIView.TextFieldType?>.Binding
    @Binding var animationTrigger: Bool
    
    var body: some View {
        ZStack {
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
                        .strokeBorder(!wrongAttempt ? ColorManager.primaryColor : ColorManager.negativeColor, lineWidth: 2)
                        .opacity(isFocused.wrappedValue == .password ? 1.0 : 0.0)
                        .background(isFocused.wrappedValue == .password ? ColorManager.background.cornerRadius(10) : ColorManager.background2.cornerRadius(10))
                        .animation(Animation.easeIn(duration: 0.25), value: isFocused.wrappedValue == .password)
            )
        }
        .offset(x: !wrongAttempt || !animationTrigger ? 0 : -10)
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
