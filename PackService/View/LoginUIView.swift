//
//  LoginUIView.swift
//  PackService
//
//  Created by 박윤환 on 2022/12/30.
//

import SwiftUI

struct LoginUIView: View {
    
    @State var signUpScreen: Bool = false // 회원가입 진행 bool 변수
    @StateObject var kakaoAuthVM = KakaoAuthVM()
    @StateObject var appleAuthVM = AppleAuthVM()
    @ObservedObject var emailAuthVM = EmailAuthVM()
    // ------
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
                ZStack {
                    if signUpScreen {
                        MemberShipAgreementView(isFirstLaunching: .constant(false), signUpScreen: $signUpScreen)
                            .transition(.move(edge: .bottom))
                            .animation(.spring())
                    } else {
                        Color.white
                            .edgesIgnoringSafeArea(.all)
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
                                        } else {
                                            emailAuthVM.login(email: emailInput, password: passwordInput)
                                            print("로그인 되었음")
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
                                            signUpScreen.toggle()
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
                                        kakaoAuthVM.handleKakaoLogin()
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
                }
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
        if checkEmail(str: emailInput) {
            self.isEmailValid = true
            
            if checkPassword(str: passwordInput) {
                self.isPasswordValid = true
                self.focusState = .password
                return
            }
        } else if !checkEmail(str: emailInput) && passwordInput.isEmpty {
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

func checkEmail(str: String) -> Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
    return  NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: str)
}

func checkPassword(str: String) -> Bool {
    let passwordRegex = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,50}"
    return  NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: str)
}

struct LoginUIView_Previews: PreviewProvider {
    
    @Binding var text: String
    
    static var previews: some View {
        LoginUIView()
    }
}
