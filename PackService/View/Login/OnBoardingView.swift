//
//  OnBoardingView.swift
//  PackService
//
//  Created by 박윤환 on 2022/12/30.
//

import SwiftUI
import AuthenticationServices

//MARK: - OnBoardingView
struct OnBoardingView: View {    
    @Binding var isFirstLaunching: Bool
    @State var signUpScreen: Bool = false
    @EnvironmentObject var service: LoginService
    @State private var appleAuthVM: AppleAuthViewModel?
    @Environment(\.window) var window: UIWindow?
    
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
                        //Apple SignUp
                        Button {
                            handleAppleLogin()
                        } label: {
                            ThirdPartyButtonView(type: .apple)
                        }
                        .buttonStyle(ContainerButtonStyle())
                        
                        //Kakao SignUp
                        Button {
                            service.handleKakaoLogin()
                        } label: {
                            ThirdPartyButtonView(type: .kakao)
                        }
                        
                        //Email SignUp
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
                        
                        NavigationLink(destination: LoginView()) {
                            Text("로그인")
                                .foregroundColor(Color("primary_color"))
                                .overlay(
                                    Rectangle()
                                        .frame(height: 1)
                                        .offset(y: 2)
                                        .foregroundColor(Color("primary_color"))
                                    , alignment: .bottom)
                        }
                    }
                    .font(FontManager.body2)
                }
                .padding(.vertical, 41)
                if signUpScreen {
                    SignUpView(isFirstLaunching: $isFirstLaunching, signUpScreen: $signUpScreen)
                        .transition(.move(edge: .bottom))
                        .animation(.spring())
                }
            }
        }
    }
    
    //MARK: - handleAppleLogin()
    func handleAppleLogin() {
        appleAuthVM = AppleAuthViewModel(window: window)
        appleAuthVM?.startAppleLogin()
    }
}

//struct OnBoardingView_Previews: PreviewProvider {
//    static var previews: some View {
//        OnBoardingView(isFirstLaunching: .constant(true))        
//    }
//}
