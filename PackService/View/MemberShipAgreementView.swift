//
//  MemberShipAgreementView.swift
//  PackService
//
//  Created by 이범준 on 12/21/22.
//

import SwiftUI

struct MemberShipAgreementView: View {

    @ObservedObject var viewModel = EmailAuthVM() 
    @Binding var signUpScreen: Bool
    @State var serviceAgreeScreen: Bool = false // servceAgreeDescriptView 화면 전환 변수
    @State var personAgreeScreen: Bool = false // personAgreeDescriptView 화면 전환 변수
    @State var nextSignUpScreen: Bool = false // 약관동의 후 회원가입 화면 진행
    @State var allAgree: Bool = false
    @State var ageAgree: Bool = false
    @State var serviceAgree: Bool = false
    @State var personInfoAgree: Bool = false
    
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
    // ----------
    
    var body: some View {
        Color.white
            .edgesIgnoringSafeArea(.all)
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Button(action: {
                    signUpScreen.toggle()
                }, label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .foregroundColor(.black)
                        .frame(width: 25, height: 25)
                        .font(.largeTitle)
                        .padding(.bottom, 20)
                })
                
                Text("계정을\n만들어주세요")
                    .font(FontManager.title1)
                
                HStack(spacing: 0) {
                    Button(action: {
                        allAgree.toggle()
                        ageAgree = allAgree
                        serviceAgree = allAgree
                        personInfoAgree = allAgree
                    }, label: {
                        ToggleButtonView(agree: allAgree)
                    })
                    .padding(.top, 25)
                    Text("전체 동의하기")
                        .padding(.top, 24)
                        .padding(.leading, 16)
                        .font(FontManager.body1)
                }
                
                if !ageAgree || !serviceAgree || !personInfoAgree { // 전체 동의하기 안 눌렸을 경우
                    
                    HStack(spacing: 0) {
                        Button(action: {
                            ageAgree.toggle()
                        }, label: {
                            ToggleButtonView(agree: ageAgree)
                        })
                        .padding(.top, 16)
                        ToggleTextView(text: "만 14세 이상입니다")
                    }

                    // 서비스 이용약관 동의
                    HStack(spacing: 0) {
                        Button(action: {
                            serviceAgree.toggle()
                        }, label: {
                            ToggleButtonView(agree: serviceAgree)
                        })
                        .padding(.top, 16)
                        ToggleTextView(text: "서비스 이용 약관")
                        Button(action: {
                            serviceAgreeScreen.toggle()
                        }, label: {
                            ToggleDetailTextView()
                        })
                    }
                    
                    // 개인정보 동의
                    HStack(spacing: 0) {
                        Button(action: {
                            personInfoAgree.toggle()
                        }, label: {
                            ToggleButtonView(agree: personInfoAgree)
                        })
                        .padding(.top, 16)
                        ToggleTextView(text: "개인정보 수집 및 이용 동의")
                        Button(action: {
                            personAgreeScreen.toggle()
                        }, label: {
                            ToggleDetailTextView()
                        })
                    }
                } else { // 전체 동의하기가 눌렸을 경우
                    VStack {
                        TextFieldView(title: "이메일", input: $emailInput, wrongAttempt: $emailAttempt, isFocused: $focusState, animationTrigger: $animationTrigger, type: .email)
                        
                        TextFieldView(title: "비밀번호", input: $passwordInput, wrongAttempt: $passwordAttempt, isFocused: $focusState, animationTrigger: $animationTrigger, type: .password, isSecure: true)
                        TextFieldView(title: "비밀번호 확인", input: $passwordConfirmInput, wrongAttempt: $passwordConfirmAttempt, isFocused: $focusState, animationTrigger: $animationTrigger, type: .passwordConfirm, isSecure: true)
                        Spacer()
                    }
                    .onAppear(perform: {
                        // 뷰가 나타날떄 수행 할 코드
                        allAgree = true
                    })
                    .padding(.trailing, 20)
                    .padding(.top, 20)
                    .animation(Animation.easeIn, value: allAgree)
                    .onSubmit {
                        toggleFocus()
                    }
                }
                Spacer()
            }
            Spacer()
        }
        .padding(.leading, 20)
        
        VStack {
            Spacer()
            if ageAgree && serviceAgree && personInfoAgree { //버튼 활성화 조건
                Button(action: {
//                    viewModel.registerUser(email: emailInput, password: passwordInput)
                    isSubmitted = true
                    validationCheck()
                    
                    emailAttempt = (isSubmitted && !isEmailValid)
                    passwordAttempt = (isSubmitted && !isPasswordValid)
                    passwordConfirmAttempt = (isSubmitted && !isPasswordConfirmValid)
                    
                    if !(isEmailValid && isPasswordValid) {
                        withAnimation(Animation.spring(response: 0.2, dampingFraction: 0.2, blendDuration: 0.2)) {
                            animationTrigger = true
                        }
                    }
                    
                    animationTrigger = false
                }, label: {
                    ButtonView(text: "계정 만들기")
                })
                .padding(.leading, 20)
                .padding(.trailing, 20)
            } else {
                Button(action: {
                }, label: {
                    DisabledButtonView(text: "계정 만들기")
                })
                .disabled(true)
                .padding(.leading, 20)
                .padding(.trailing, 20)
            }
        }
        if serviceAgreeScreen {
            NoSafeAreaServiceAgreeView(serviceAgreeScreen: $serviceAgreeScreen)
                .transition(.move(edge: .bottom))
                .animation(.spring())
        }
        if personAgreeScreen {
            PersonAgreeDescriptView(personAgreeScreen: $personAgreeScreen)
                .transition(.move(edge: .bottom))
                .animation(.spring())
        }
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
        
        self.isPasswordValid = false
        self.focusState = .password
        
    }
}

struct ToggleTextView: View { // "만 14세 이상입니다" 글씨 함수
    var text: String
    var body: some View {
        Text(text)
            .padding(.top, 20)
            .padding(.leading, 16)
            .font(FontManager.body2)
    }
}

struct ToggleDetailTextView: View { // "보기" 글씨 함수
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

struct MemberShipAgreementView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
