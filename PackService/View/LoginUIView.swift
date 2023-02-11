//
//  LoginUIView.swift
//  PackService
//
//  Created by 박윤환 on 2022/12/30.
//

import SwiftUI

struct LoginUIView: View {
    
    @State var signUpScreen: Bool = false // 회원가입 진행 bool 변수
    @Environment(\.window) var window: UIWindow?
    @AppStorage("log_status") var logStatus = false
    @EnvironmentObject var emailService: EmailService
    @State private var appleAuthVM: AppleAuthViewModel?
    // ------
    @State var signUpErrorMessage: String = ""
    
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
                                    HStack { // 이메일 존재할 때
                                        if emailService.loginError == "" {
                                            Text(signUpErrorMessage)
                                                .font(FontManager.caption2)
                                                .foregroundColor(ColorManager.negativeColor)
                                        } else { // 이메일 존재하지 않을때
                                            Text(emailService.loginError)
                                                .font(FontManager.caption2)
                                                .foregroundColor(ColorManager.negativeColor)
                                        }
                                        Spacer()
                                    }
                                    
                                    Button {
                                        isSubmitted = true
//                                        validationCheck()
                                        signUpErrorMessages()
                                        emailAttempt = (isSubmitted && !isEmailValid)
                                        passwordAttempt = (isSubmitted && !isPasswordValid)
                                        
                                        if !(isEmailValid && isPasswordValid) {
                                            withAnimation(Animation.spring(response: 0.2, dampingFraction: 0.2, blendDuration: 0.2)) {
                                                animationTrigger = true
                                            }
                                        } else {
                                            emailService.login(email: emailInput, password: passwordInput)
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
                                        handleAppleLogin()
                                    } label: {
                                        ThirdPartyButtonView(type: .apple)
                                    }
                                    .buttonStyle(ContainerButtonStyle())
                                    
                                    Button {
                                        emailService.handleKakaoLogin()
                                    } label: {
                                        ThirdPartyButtonView(type: .kakao)
                                    }
                                    .buttonStyle(ContainerButtonStyle())
                                    
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
            if checkEmail(str: emailInput) {
                focusState = .email
            } /*else if checkEmail(str: emailInput) && notEmail()*/
//            else if checkEmail(str: emailInput) {
//                focusState = .password
//            }
        } else if focusState == .password {
            if checkPassword(str: passwordInput) {
                focusState = .password
            } else {
                focusState = nil
            }
        }
    }
    
    func signUpErrorMessages() {
        if !checkEmail(str: emailInput) {
            self.signUpErrorMessage = "올바른 이메일 주소를 입력하세요"
            self.isEmailValid = false
            self.focusState = .email
        } else if !checkPassword(str: passwordInput) {
            self.signUpErrorMessage = "비밀번호는 8이상의 영어,숫자,특수문자를 입력하세요"
            self.isPasswordValid = false
            self.focusState = .password
        } else {
            self.isEmailValid = true
            self.isPasswordValid = true
        }
        //이메일이 존재합니다
    }
    
    //func toggleFocus() {
    //        if focusState == .email {
    //            if 이메일 형식이 아니면  {
    //                focusState = .email
    //            } else if 이메일 형식은 맞는데 이메일이 존재하지 않음 {
    //                return
    //            } else if 이메일 형식도 맞고 이메일이 존재함 {
    //                focusState = .password
    //            }
    //        } else if focusState == .password {
    //            if 비밀번호 조합이 아니면 {
    //                focusState = .password
    //            } else if
    //            focusState = nil
    //        }
    //    }
    
    func validationCheck() {
        if checkEmail(str: emailInput) {
            self.isEmailValid = true
            
            if checkPassword(str: passwordInput) {
                self.isPasswordValid = true
//                self.focusState = .password
                return
            }
        } else if !checkEmail(str: emailInput) && passwordInput.isEmpty {
            self.isEmailValid = false
//            self.focusState = .email
            return
        } else {
            self.isEmailValid = false
        }
        
        self.isPasswordValid = false
//        self.focusState = .password
        
    }
    
    func handleAppleLogin() {
        print("startapplelogin함수 시작")
        emailService.loginLoading = true
        appleAuthVM = AppleAuthViewModel(window: window)
        appleAuthVM?.startAppleLogin()
        print("apple logStatus click1 \(self.logStatus)")
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
