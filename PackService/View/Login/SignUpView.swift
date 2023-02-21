//
//  MemberShipAgreementView.swift
//  PackService
//
//  Created by 이범준 on 12/21/22.
//

import SwiftUI

struct SignUpView: View {
    @Binding var isFirstLaunching: Bool // 온보딩 1회만 실행되도록 하는 변수
    @State var checkSignupError: Bool = true
    @State var signUpErrorMessage: String = ""
    @EnvironmentObject var service: LoginService
    @Binding var signUpScreen: Bool
    @State var showTermsOfServiceScreen: Bool = false // servceAgreeDescriptView 화면 전환 변수
    @State var showPrivacyPolicyScreen: Bool = false // personAgreeDescriptView 화면 전환 변수
    @State var allAgree: Bool = false
    @State var ageAgree: Bool = false
    @State var termsOfServiceAgree: Bool = false
    @State var privacyPolicyAgree: Bool = false
    
    // 텍스트 필드 애니메이션 변수들
    @State var emailInput: String = ""
    @State var passwordInput: String = ""
    @State var passwordConfirmInput: String = ""
    
    @State var isEmailValid: Bool = true
    @State var isPasswordValid: Bool = true
    @State var isPasswordConfirmValid: Bool = true
    
    @State var isSubmitted: Bool = false
    
    @State var emailAttempt: Bool = false
    @State var passwordAttempt: Bool = false
    @State var passwordConfirmAttempt: Bool = false
    
    @State var animationTrigger: Bool = false
    @FocusState private var focusState: TextFieldType?
    
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Button(action: {
                        signUpScreen = false
                    }, label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .foregroundColor(.black)
                            .frame(width: 18, height: 18)
                            .font(.largeTitle)
                            .padding(.bottom, 20)
                    })
            
                    Text("계정을\n만들어주세요")
                        .font(FontManager.title1)
                    
                    allAgreeView

                    if !ageAgree || !termsOfServiceAgree || !privacyPolicyAgree {
                        ageAgreeView
                        serviceAgreeView
                        personInfoAgreeView
                    } else {
                        VStack {
                            TextFieldView(title: "이메일", input: $emailInput, wrongAttempt: $emailAttempt, animationTrigger: $animationTrigger, isFocused: $focusState, type: .email)
                                .submitLabel(.next)
                            
                            TextFieldView(title: "비밀번호", input: $passwordInput, wrongAttempt: $passwordAttempt, animationTrigger: $animationTrigger, isFocused: $focusState, type: .password, isSecure: true)
                                .submitLabel(.next)
                            
                            TextFieldView(title: "비밀번호 확인", input: $passwordConfirmInput, wrongAttempt: $passwordConfirmAttempt, animationTrigger: $animationTrigger, isFocused: $focusState, type: .passwordConfirm, isSecure: true)
                                .submitLabel(.return)
                            
                            HStack {
                                if service.signUpError == "" {
                                    Text(signUpErrorMessage)
                                        .font(FontManager.caption2)
                                        .foregroundColor(ColorManager.negativeColor)
                                } else if service.signUpError == "이미 해당 이메일이 존재합니다" {
                                    Text(service.signUpError)
                                        .font(FontManager.caption2)
                                        .foregroundColor(ColorManager.negativeColor)
                                } else if service.signUpError == "회원가입이 완료되었습니다"{
                                    Text(service.signUpError)
                                        .font(FontManager.caption2)
                                        .foregroundColor(ColorManager.negativeColor)
                                        .onAppear {
                                            signUpScreen = false
                                        }
                                }
                                
                                Spacer()
                            }
                            
                            Spacer()
                        }
    //                    .onAppear {
    //                        allAgree = true
    //                    }
                        .padding(.top, 20)
                        .animation(Animation.easeIn, value: allAgree)
                        .onSubmit {
                            toggleFocus()
                        }
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .onAppear {
                service.signUpError = ""
            }

            VStack {
                Spacer()
                
                signUpButtonView
            }
                    
            if showTermsOfServiceScreen {
                TermsOfServiceView(showTermsOfService: $showTermsOfServiceScreen)
                    .padding(.horizontal, 20)
                    .transition(.move(edge: .bottom))
                    .animation(.spring())
            }
            
            if showPrivacyPolicyScreen {
                PrivacyPolicyView(showPrivacyPolicy: $showPrivacyPolicyScreen)
                    .padding(.horizontal, 20)
                    .transition(.move(edge: .bottom))
                    .animation(.spring())
            }
        }
    }
    
    func toggleFocus() {
        if focusState == .email {
            focusState = .password
        } else if focusState == .password {
            focusState = .passwordConfirm
        } else if focusState == .passwordConfirm {
            focusState = nil
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
        } else if passwordInput != passwordConfirmInput {
            self.signUpErrorMessage = "비밀번호와 비밀번호 확인이 일치하지 않습니다"
            self.isPasswordConfirmValid = false
            self.focusState = .passwordConfirm
        } else if service.signUpError == "" {
            self.checkSignupError = false
        }
    }
}

// 동의하기 버튼들
extension SignUpView {
    var allAgreeView: some View {
        HStack(spacing: 0) {
            Button(action: {
                allAgree.toggle()
                ageAgree = allAgree
                termsOfServiceAgree = allAgree
                privacyPolicyAgree = allAgree
            }, label: {
                ToggleButtonView(agree: allAgree)
            })
            .padding(.top, 25)
            
            Text("전체 동의하기")
                .padding(.top, 24)
                .padding(.leading, 16)
                .font(FontManager.body1)
        }
    }
    
    var ageAgreeView: some View {
        HStack(spacing: 0) {
            Button(action: {
                ageAgree.toggle()
            }, label: {
                ToggleButtonView(agree: ageAgree)
            })
            .padding(.top, 16)
            ToggleTextView(text: "만 14세 이상입니다")
        }
    }
    
    var serviceAgreeView: some View {
        HStack(spacing: 0) {
            
            Button(action: {
                termsOfServiceAgree.toggle()
            }, label: {
                ToggleButtonView(agree: termsOfServiceAgree)
            })
            .padding(.top, 16)
            
            ToggleTextView(text: "서비스 이용 약관")
            
            Button(action: {
                showTermsOfServiceScreen.toggle()
            }, label: {
                ToggleDetailTextView()
            })
        }
    }
    
    var personInfoAgreeView: some View {
        HStack(spacing: 0) {
            
            Button(action: {
                privacyPolicyAgree.toggle()
            }, label: {
                ToggleButtonView(agree: privacyPolicyAgree)
            })
            .padding(.top, 16)
            
            ToggleTextView(text: "개인정보 수집 및 이용 동의")
            
            Button(action: {
                showPrivacyPolicyScreen.toggle()
            }, label: {
                ToggleDetailTextView()
            })
        }
    }
    
    var signUpButtonView: some View {
        Button(action: {
            isSubmitted = true
//            validationCheck()
            signUpErrorMessages() // 회원가입 정보 에러 없는지 확인
            emailAttempt = (isSubmitted && !isEmailValid)
            passwordAttempt = (isSubmitted && !isPasswordValid)
            passwordConfirmAttempt = (isSubmitted && !isPasswordConfirmValid)

            if (isEmailValid) {
                withAnimation(Animation.spring(response: 0.2, dampingFraction: 0.2, blendDuration: 0.2)) {
                    animationTrigger = true
                }
            }
            
            if checkSignupError == false {// 회원가입 시 에러 없어야지 파이어베이스 등록
                service.registerUser(email: emailInput, password: passwordInput)
//                signUpSuccessAlert = true
            }
            animationTrigger = false
        }, label: {
            ButtonView(text: "계정 만들기")
//            if emailInput != "" && passwordInput != "" && passwordConfirmInput != "" {
//
//            } else {
//                DisabledButtonView(text: "계정 만들기")
//            }
        })
        .padding(.horizontal, 20)
        .disabled(emailInput.isEmpty && passwordInput.isEmpty && passwordConfirmInput.isEmpty)
//        .alert(isPresented: $signUpSuccessAlert) {
//            Alert(title: Text("Alert"),
//                  message: Text("Alert Dialog"),
//                  dismissButton: .default(Text("Close")))
//        }
    }
}

// "만 14세 이상입니다" 글씨 구조체
struct ToggleTextView: View {
    var text: String
    var body: some View {
        Text(text)
            .padding(.top, 20)
            .padding(.leading, 16)
            .font(FontManager.body2)
    }
}

// "보기" 글씨 구조체
struct ToggleDetailTextView: View {
    var body: some View {
        Text("보기")
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .offset(y: 1)
                    .foregroundColor(ColorManager.foreground2)
                , alignment: .bottom)
            .padding(.top, 16)
            .padding(.leading, 8)
            .font(FontManager.body2)
            .foregroundColor(ColorManager.foreground2)
    }
}


//
//struct MemberShipAgreementView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}


//    func validationCheck() {
//        if checkEmail(str: emailInput) { // 이메일 옳을때
//            self.isEmailValid = true
//
//            if checkPassword(str: passwordInput) { // 비밀번호도 옳을때
//                self.isPasswordValid = true
//                self.focusState = .password
//                return
//            }
//        } else if !checkEmail(str: emailInput) && checkPassword(str: passwordInput){ // 이메일도 틀리고 패스워드도 틀리면
//            self.isEmailValid = false
//            self.focusState = .email
//            return
//        } else {
//            self.isEmailValid = false
//        }
//
//        self.isPasswordValid = false
//        self.focusState = .password
//
//    }
//    func validationCheck() {
//        if !checkEmail(str: emailInput) {
//            self.isEmailValid = false
//            self.focusState = .email
//        }
//    }
    
