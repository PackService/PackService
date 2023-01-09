//
//  LoginUIView.swift
//  PackService
//
//  Created by 박윤환 on 2022/12/30.
//

import SwiftUI

struct LoginUIView: View {
    
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
                            TextFieldView(title: "이메일", input: $emailInput, wrongAttempt: $emailAttempt, isFocused: $focusState, animationTrigger: $animationTrigger, type: .email)
                            
                            TextFieldView(title: "비밀번호", input: $passwordInput, wrongAttempt: $passwordAttempt, isFocused: $focusState, animationTrigger: $animationTrigger, type: .password, isSecure: true)
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

struct LoginUIView_Previews: PreviewProvider {
    
    @Binding var text: String
    
    static var previews: some View {
        LoginUIView()
    }
}
