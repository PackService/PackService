//
//  OnBoardingView.swift
//  PackService
//
//  Created by 박윤환 on 2022/12/30.
//

import SwiftUI
import AuthenticationServices


struct OnBoardingView: View {
    @Binding var isFirstLaunching: Bool //1회만 실행되도록 하는 변수
    @State var signUpScreen: Bool = false // 회원가입 진행 bool 변수
    @StateObject var kakaoAuthVM = KakaoAuthVM()
    @StateObject var appleAuthVM = AppleAuthVM()
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .center) {
                    Text("내 소중한 택배의\n우당탕탕 대모험 📦")
                        .multilineTextAlignment(.center)
                        .font(FontManager.title1)
                        .lineSpacing(5)
                    
                    Spacer()
                    
                    VStack(spacing: 16) {
                        Button {
                            kakaoAuthVM.handleKakaoLogin()
                            isFirstLaunching.toggle()
                        } label: {
                            ThirdPartyButtonView(type: .kakao)
                        }
                        
                        Button {
                            signUpScreen.toggle()
                        } label: {
                            ThirdPartyButtonView(type: .email)
                        }

                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 16)
                    
                    HStack {
                        Text("이미 계정이 있나요?")
                            .foregroundColor(Color("foreground1"))
                        
                        Button(action: {
                            isFirstLaunching.toggle()
                        }, label: {
                            Text("로그인")
                                .foregroundColor(Color("primary_color"))
                                .overlay(
                                    Rectangle()
                                        .frame(height: 1)
                                        .offset(y: 2)
                                        .foregroundColor(Color("primary_color"))
                                    , alignment: .bottom)
                        })
                    }
                    .font(FontManager.body2)
                }
                .padding(.vertical, 41)
                if signUpScreen { // 회원가입 화면 이동
                    MemberShipAgreementView(isFirstLaunching: $isFirstLaunching, signUpScreen: $signUpScreen)
                        .transition(.move(edge: .bottom))
                        .animation(.spring())
                }
            }
        }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView(isFirstLaunching: .constant(true))        
    }
}
