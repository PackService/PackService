//
//  LoginView.swift
//  PackService
//
//  Created by 이범준 on 11/28/22.
//

import SwiftUI
import AuthenticationServices


struct LoginView: View {
    @State var email = ""
    @State var pw = ""
    @ObservedObject var viewModel = AuthViewModel()
        
    @StateObject var kakaoAuthVM = KakaoAuthVM()
    @StateObject var appleLoginData = AppleAuthVM()
    let loginStatusInfo: (Bool) -> String = { isLoggedIn in
        return isLoggedIn ? "로그인 상태" : "로그아웃 상태"
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text(loginStatusInfo(kakaoAuthVM.isLoggedIn)).padding()
//            TextField("id", text: $id)
//            SecureField("PW", text: $password)
//            TextField("email", text: $email)
//            TextField("nickName", text: $nickName)
//            TextField("name", text: $name)
//            TextField("address", text: $address)
//            Button {
//                viewModel.registerUser(id, password, nickName, address, email, name)
//            } label: {
//                Text("등록")
//            }
//            TextField("Email", text: $email)
//            SecureField("PW", text: $pw)
//            Button {
//                viewModel.registerUser(email: email, password: pw)
//            } label: {
//                Text("등록")
//            }
//
            Button("카카오 로그인", action: {
                kakaoAuthVM.handleKakaoLogin()
            })
            Button("카카오 로그아웃", action: {
                kakaoAuthVM.kakaoLogout()
            })

            
            SignInWithAppleButton { (request) in
                appleLoginData.nonce = randomNonceString()
                request.requestedScopes = [.email,.fullName]
                request.nonce = sha256(appleLoginData.nonce)
                print(request)
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
            .frame(height: 55)
            .clipShape(Capsule())
            .padding(.horizontal,30)
            .offset(y: 70)
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
