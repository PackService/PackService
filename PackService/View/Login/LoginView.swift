//
//  LoginUIView.swift
//  PackService
//
//  Created by 박윤환 on 2022/12/30.
//

import SwiftUI

//MARK: - LoginView
struct LoginView: View {
    
    @State var signUpScreen: Bool = false
    @Environment(\.window) var window: UIWindow?
    @AppStorage("log_status") var logStatus = false
    @EnvironmentObject var service: LoginService
    @State private var appleAuthVM: AppleAuthViewModel?
    
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
                        SignUpView(isFirstLaunching: .constant(false), signUpScreen: $signUpScreen)
                            .transition(.move(edge: .bottom))
                            .animation(.spring())
                    } else {
                        Color.white
                            .edgesIgnoringSafeArea(.all)
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack {
                                HStack {
                                    Image("easytrack")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 60, height: 60)
                                    
                                    Text("쉽고")
                                        .font(.custom("Pretendard-Bold", size: 40.0))
                                        .fontWeight(.heavy)
                                        .foregroundColor(ColorManager.primaryColor)
                                }
                                .padding(.bottom, 40)
                                
                                
                                Spacer()
                                
                                VStack(spacing: 16) {
                                    VStack {
                                        TextFieldView(title: "이메일", input: $emailInput, wrongAttempt: $emailAttempt, animationTrigger: $animationTrigger, isFocused: $focusState, type: .email)
                                            .submitLabel(.next)
                                        
                                        TextFieldView(title: "비밀번호", input: $passwordInput, wrongAttempt: $passwordAttempt, animationTrigger: $animationTrigger, isFocused: $focusState, type: .password, isSecure: true)
                                            .submitLabel(.return)
                                    }
                                    .onSubmit {
                                        toggleFocus()
                                    }
                                    
                                    HStack {
                                        if service.loginError == "" {
                                            Text(signUpErrorMessage)
                                                .font(FontManager.caption2)
                                                .foregroundColor(ColorManager.negativeColor)
                                        } else {
                                            Text(service.loginError)
                                                .font(FontManager.caption2)
                                                .foregroundColor(ColorManager.negativeColor)
                                        }
                                        
                                        Spacer()
                                    }
                                    
                                    Button {
                                        isSubmitted = true
                                        
                                        signUpErrorMessages()
                                        
                                        emailAttempt = (isSubmitted && !isEmailValid)
                                        passwordAttempt = (isSubmitted && !isPasswordValid)
                                        
                                        if !(isEmailValid && isPasswordValid) {
                                            withAnimation(Animation.spring(response: 0.2, dampingFraction: 0.2, blendDuration: 0.2)) {
                                                animationTrigger = true
                                            }
                                        } else {
                                            service.login(email: emailInput, password: passwordInput)
                                        }
                                        
                                        animationTrigger = false
                                    } label: {
                                        ButtonView(text: "로그인")
                                    }
                                    .padding(.top, 20)
                
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
                                    
                                    //Apple Login
                                    Button {
                                        handleAppleLogin()
                                    } label: {
                                        ThirdPartyButtonView(type: .apple)
                                    }
                                    .buttonStyle(ContainerButtonStyle())
                                    
                                    //Kakao Login
                                    Button {
                                        service.handleKakaoLogin()
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
    
    //MARK: - toggleFocus()
    func toggleFocus() {
        if focusState == .email {
            focusState = .password
        } else if focusState == .password {
            focusState = nil
        }
    }
    
    //MARK: - signUpErrorMessages()
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
    }
    
    //MARK: - validationCheck()
    func validationCheck() {
        if checkEmail(str: emailInput) {
            self.isEmailValid = true
            
            if checkPassword(str: passwordInput) {
                self.isPasswordValid = true
                return
            }
        } else if !checkEmail(str: emailInput) && passwordInput.isEmpty {
            self.isEmailValid = false
            return
        } else {
            self.isEmailValid = false
        }
        
        self.isPasswordValid = false
    }
    
    //MARK: - handleAppleLogin()
    func handleAppleLogin() {
        print("startapplelogin함수 시작")
        appleAuthVM = AppleAuthViewModel(window: window)
        appleAuthVM?.startAppleLogin()
        print("apple logStatus click1 \(self.logStatus)")
    }
}

//MARK: - checkEmail(str:)
func checkEmail(str: String) -> Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
    return  NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: str)
}

//MARK: - checkPassword(str:)
func checkPassword(str: String) -> Bool {
    let passwordRegex = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,50}"
    return  NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: str)
}

//struct LoginUIView_Previews: PreviewProvider {
//
//    @Binding var text: String
//
//    static var previews: some View {
//        LoginView()
//    }
//}
