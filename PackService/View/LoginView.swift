//
//  LoginView.swift
//  PackService
//
//  Created by 이범준 on 11/28/22.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @StateObject var kakaoAuthVM = KakaoAuthVM()
    @StateObject var appleLoginData = AppleAuthVM()
    let loginStatusInfo: (Bool) -> String = { isLoggedIn in
        return isLoggedIn ? "로그인 상태" : "로그아웃 상태"
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text(loginStatusInfo(kakaoAuthVM.isLoggedIn)).padding()
            Button("카카오 로그아웃", action: {
                kakaoAuthVM.kakaoLogout()
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
