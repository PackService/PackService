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
    @State var emailInput: String = ""
    @State var passwordInput: String = ""
    @State var passwordCheckInput: String = ""
    // 텍스트 필드 애니메이션 변수들
    enum TextFieldType: Hashable {
        case email
        case password
        //case passwordCheck
    }
    @State var isEmailValid: Bool = false
    @State var isPasswordValid: Bool = false
    @State var isSubmitted: Bool = false
    @State var isAnimated: Bool = false
    @FocusState private var focusState: TextFieldType?
    //
    
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
                        InputTextField2(title: "이메일", input: $emailInput, isValid: $isEmailValid, isSubmitted: $isSubmitted, isFocused2: $focusState)
                            .offset(x: !(isSubmitted && !isEmailValid) || !isAnimated ? 0 : -10)
                            .onAppear(perform: {
                                allAgree = true
                            })
                        
                        SecureInputTextField2(title: "비밀번호", input: $passwordInput, isValid: $isPasswordValid, isSubmitted: $isSubmitted, isFocused: $focusState)
                            .offset(x: !(isSubmitted && !isPasswordValid) || !isAnimated ? 0 : -10)
                        
                        SecureInputTextField2(title: "비밀번호 확인", input: $passwordCheckInput, isValid: $isPasswordValid, isSubmitted: $isSubmitted, isFocused: $focusState)
                            .offset(x: !(isSubmitted && !isPasswordValid) || !isAnimated ? 0 : -10)
                        Spacer()
                    }
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
                    viewModel.registerUser(email: emailInput, password: passwordInput)
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
            ServiceAgreeDescriptView(serviceAgreeScreen: $serviceAgreeScreen)
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

struct InputTextField2: View {

    @State var title: String = ""
//    @FocusState var isFocused: Bool
    @Binding var input: String
    @Binding var isValid: Bool
    @Binding var isSubmitted: Bool
    var isFocused2: FocusState<MemberShipAgreementView.TextFieldType?>.Binding

    var body: some View {
        TextField("", text: $input)
            .focused(isFocused2, equals: .email)
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
                    .opacity(self.isFocused2.wrappedValue == .email ? 1.0 : 0.0)
                    .background(self.isFocused2.wrappedValue == .email ? ColorManager.background.cornerRadius(10) : ColorManager.background2.cornerRadius(10))
                    .animation(Animation.easeIn(duration: 0.25), value: self.isFocused2.wrappedValue == .email)
            )

    }
}

struct SecureInputTextField2: View {

    @State var title: String = ""
//    @FocusState private var isFocused: Bool
    @Binding var input: String
    @Binding var isValid: Bool
    @Binding var isSubmitted: Bool
    var isFocused: FocusState<MemberShipAgreementView.TextFieldType?>.Binding

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

struct MemberShipAgreementView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
