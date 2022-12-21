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
    @StateObject var kakaoAuthVM = KakaoAuthVM()
    @StateObject var appleLoginData = AppleAuthVM()
    @State var firstNaviLinkActive = false
    
    var body: some View {
        NavigationView {
            ZStack{
                Color(red: 52 / 255, green: 152 / 255, blue: 219 / 255).ignoresSafeArea()
                VStack(spacing: 20) {
                    TextField("이메일", text: $emailInput).keyboardType(.emailAddress).autocapitalization(.none)
                    SecureField("비밀번호", text: $passwordInput).keyboardType(.default)
                    // 추후에 카카오 로그아웃 할 때 참고
                    //            Button("카카오 로그아웃", action: {
                    //                kakaoAuthVM.kakaoLogout()
                    //            })
                    NavigationLink(destination: MemberShipAgreementView(firstNaviLinkActive: $firstNaviLinkActive), isActive: $firstNaviLinkActive) {
                        Text("Click Here")
                            .foregroundColor(Color.white)
                            .frame(width: 100, height: 60, alignment: .center)
                            .background(RoundedRectangle(cornerRadius: 10)
                                .fill(Color.red))
                    }
                    .navigationBarHidden(true)
                    
                    Button(action: {
                        print("로그인 버튼 클릭되었음")
                    }, label: {
                        Text("로그인")
                    })
                    
                    Button(action: {kakaoAuthVM.handleKakaoLogin()}){
                        Image("kakao_login_large_wide")
                            .resizable()
                            .frame(height: 45)
                            .clipShape(Rectangle())
                            .padding(.horizontal,30)
                    }
                    
                    SignInWithAppleButton { (request) in
                        appleLoginData.nonce = randomNonceString()
                        request.requestedScopes = [.email,.fullName]
                        request.nonce = sha256(appleLoginData.nonce)
                    } onCompletion: { (result) in
                        //getting error or success
                        switch result {
                        case .success(let user):
                            print("apple login success")
                            guard let credential = user.credential as? ASAuthorizationAppleIDCredential else {
                                print("error with firebase")
                                return
                            }
                            appleLoginData.authenticate(credential: credential)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    .signInWithAppleButtonStyle(.black)
                    .frame(height: 45)
                    .clipShape(Rectangle())
                    .padding(.horizontal,30)
                    .offset(y: 0)
                }
                .padding()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
