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
    @State var allAgree: Bool = false
    @State var ageAgree: Bool = false
    @State var serviceAgree: Bool = false
    @State var personInfoAgree: Bool = false
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
                
                Text("계정을")
                    .padding(.leading, 20)
                    .font(FontManager.title1)
                Text("만들어주세요")
                    .padding(.leading, 20)
                    .font(FontManager.title1)
                
                HStack(spacing: 0) {
                    Button(action: {
                        allAgree.toggle()
                        ageAgree.toggle()
                        serviceAgree.toggle()
                        personInfoAgree.toggle()
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
                
                HStack(spacing: 0) {
                    Button(action: {
                        ageAgree.toggle()
                    }, label: {
                        ToggleButtonView(agree: ageAgree)
                    })
                    .padding(.leading, 20)
                    .padding(.top, 16)
                    Text("만 14세 이상입니다")
                        .padding(.top, 20)
                        .padding(.leading, 16)
                        .font(FontManager.body2)
                }
                
                HStack(spacing: 0) {
                    Button(action: {
                        serviceAgree.toggle()
                    }, label: {
                        ToggleButtonView(agree: serviceAgree)
                    })
                    .padding(.leading, 20)
                    .padding(.top, 16)
                    Text("서비스 이용 약관")
                        .padding(.top, 20)
                        .padding(.leading, 16)
                        .font(FontManager.body2)
                    Button(action: {
                        serviceAgreeScreen.toggle()
                    }, label: {
                        Text("보기")
                            .underline()
                            .padding(.top, 16)
                            .padding(.leading, 8)
                            .font(FontManager.body2)
                    })
                }
                
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
                        Text("보기")
                            .underline()
                            .padding(.top, 16)
                            .padding(.leading, 8)
                            .font(FontManager.body2)
                    })
                }
                
                Spacer()
            }
            Spacer()
        }
        VStack {
            Spacer()
            Button(action: {
                print("회원가입 진행")
                // 그 밑에서 화면 띄우는 거 진행해야됨 토글
            }, label: {
                // 버튼 비활성화 시키고 아닐땐 활성화 되게
                ButtonView(text: "계정 만들기")
            })
            .disabled(true) //비활성화 하는거 다시 구현
            .padding(.leading, 20)
            .padding(.trailing, 20)
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

struct MemberShipAgreementView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
