//
//  LoginView.swift
//  PackService
//
//  Created by 이범준 on 11/28/22.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @State var emailInput : String = ""
    @State var passwordInput: String = ""
    @State var signUpScreen: Bool = false // 회원가입 진행 bool 변수
    @StateObject var kakaoAuthVM = KakaoAuthVM()
    @StateObject var appleAuthVM = AppleAuthVM()
    @ObservedObject var emailAuthVM = EmailAuthVM()
    @State var firstNaviLinkActive = false
    
    var body: some View {
        NavigationView {
            ZStack{
                Color(red: 52 / 255, green: 152 / 255, blue: 219 / 255).ignoresSafeArea()
                VStack(spacing: 20) {
                    TextField("이메일", text: $emailInput).keyboardType(.emailAddress).autocapitalization(.none)
                    SecureField("비밀번호", text: $passwordInput).keyboardType(.default)
    
                    Button(action: {
                        emailAuthVM.login(email: emailInput, password: passwordInput)
                        print("로그인 버튼 클릭되었음")
                    }, label: {
                        Text("로그인")
                            .font(.system(size: 20))
                    })
                    Button {
                        emailAuthVM.logout()
                    } label: {
                        Text("로그아웃")
                            .font(.custom("Pretendard-Bold", size: 20))
                    }
                    
                    Button(action: {kakaoAuthVM.handleKakaoLogin()}){
                        Image("kakao_login_large_wide")
                            .resizable()
                            .frame(height: 45)
                            .clipShape(Rectangle())
                            .padding(.horizontal,30)
                    }
                    
                    SignInWithAppleButton { (request) in
                        appleAuthVM.nonce = randomNonceString()
                        request.requestedScopes = [.email,.fullName]
                        request.nonce = sha256(appleAuthVM.nonce)
                    } onCompletion: { (result) in
                        //getting error or success
                        switch result {
                        case .success(let user):
                            print("apple login success")
                            guard let credential = user.credential as? ASAuthorizationAppleIDCredential else {
                                print("error with firebase")
                                return
                            }
                            appleAuthVM.authenticate(credential: credential)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    .signInWithAppleButtonStyle(.black)
                    .frame(height: 45)
                    .clipShape(Rectangle())
                    .padding(.horizontal, 30)
                    .offset(y: 0)
                }
                .padding()
                
                Button(action: {
                    print("아이디/비밀번호 찾기 버튼 클릭되었음")
                }, label: {
                    Text("아이디/비밀번호 찾기")
                })
                .offset(x: -70, y: 150)
                
                Button("회원가입") {
                    signUpScreen.toggle()
                }
                if signUpScreen {
                    MemberShipAgreementView(stateSignUp: .constant(true), signUpScreen: $signUpScreen)
                        .transition(.move(edge: .bottom))
                        .animation(.spring())
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


// 추후에 카카오 로그아웃 할 때 참고
//            Button("카카오 로그아웃", action: {
//                kakaoAuthVM.kakaoLogout()
//            })
