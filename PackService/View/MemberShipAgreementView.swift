//
//  MemberShipAgreementView.swift
//  PackService
//
//  Created by 이범준 on 12/21/22.
//

import SwiftUI

struct MemberShipAgreementView: View {

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
    
    var body: some View {
        Color.white
            .edgesIgnoringSafeArea(.all)
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Button(action: {
                    signUpScreen.toggle()
                }, label: {
                    Image(systemName: "xmark")
                        .font(.largeTitle)
                })
                
                Text("계정을\n만들어주세요")
                    .padding(.leading, 20)
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
                    .padding(.leading, 20)
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
                        .padding(.leading, 20)
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
                        .padding(.leading, 20)
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
                        .padding(.leading, 20)
                        .padding(.top, 16)
                        Text("개인정보 수집 및 이용 동의")
                            .padding(.top, 17)
                            .padding(.leading, 16)
                            .font(FontManager.body2)
                        Button(action: {
                            personAgreeScreen.toggle()
                        }, label: {
                            ToggleDetailTextView()
                        })
                    }
                } else { //전체 동의하기가 눌렸을 경우
                    VStack {
                        SignUpView(signUpScreen: $signUpScreen) // 회원가입 화면 뷰 보여주기
                            .onAppear(perform: {
                                // 뷰가 나타날떄 수행 할 코드
                                allAgree = true
                            })
                    }
                    .animation(Animation.easeIn, value: allAgree)
                }
                Spacer()
            }
            Spacer()
        }
        
        VStack {
            Spacer()
            if ageAgree && serviceAgree && personInfoAgree { //버튼 활성화 조건
                Button(action: {
                    nextSignUpScreen.toggle()
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
                    .offset(y: 2)
                    .foregroundColor(ColorManager.primaryColor)
                , alignment: .bottom)
            .padding(.top, 16)
            .padding(.leading, 8)
            .font(FontManager.body2)
    }
}

struct MemberShipAgreementView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
