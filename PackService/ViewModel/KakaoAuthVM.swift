//
//  KakaoAuthVM.swift
//  PackService
//
//  Created by 이범준 on 11/29/22.
//

import SwiftUI
import Combine
import KakaoSDKAuth
import KakaoSDKUser
import Firebase

class KakaoAuthVM: ObservableObject {
    
    @Published var currentUser: Firebase.User?
    @AppStorage("log_status") var logStatus = false
    
    
    init() {
        currentUser = Auth.auth().currentUser
    }
    @MainActor
    func kakaoLogout() {
        Task {
            if await handleKakaoLogout() {
                logStatus = false
            }
        }
    }
    
    func handleKakaoLogout() async -> Bool {
        await withCheckedContinuation{ continuation in
            UserApi.shared.logout {(error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("logout() success.")
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
    func handleLoginWithKakaoTalkApp() async -> Bool {
        // 카카오 앱을 통해 로그인
        await withCheckedContinuation{ continuation in
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    
                    //do something
                    _ = oauthToken
                    continuation.resume(returning: true)
                    print(oauthToken)
                    
                }
            }
        }
    }

    func handleLoginWithKakaoAccount() async -> Bool {
        await withCheckedContinuation { continuation in
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("loginWithKakaoAccount() success.")
                    _ = oauthToken
//                    registerUser(email: <#T##String#>, password: <#T##String#>)
                    UserApi.shared.me { kuser, error in
                        if let error = error {
                            print(error)
                        } else {
                            Auth.auth().createUser(withEmail: (kuser?.kakaoAccount?.email)!, password: "\(String(describing: kuser?.id))") { fuser, error in //회원가입 실행
                                if let error = error { // 아이디가 있으면 로그인
                                    print("FB : signup failed")
                                    print(error)
                                    Auth.auth().signIn(withEmail: (kuser?.kakaoAccount?.email)!, password: "\(String(describing: kuser?.id))", completion: nil)
                                } else { // 아이디가 없으니까 firbase 연동
                                    guard let user = fuser?.user else { return } // 파이어베이스 유저 객체를 가져옴
                                    print("FB : signup success")
                                    let db = Firestore.firestore()
                                    db.collection("users").document(user.uid).setData(["email": kuser?.kakaoAccount?.email])
                                    print(user.uid)
                                }
                            }
                        }
                    }
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
    // 2554604922
    @MainActor
    func handleKakaoLogin() {
        Task {
            // 카카오톡 설치 여부 확인 - 설치 되어있을 때
            if (UserApi.isKakaoTalkLoginAvailable()) {
                //카카오 앱을 통해 로그인
                logStatus = await handleLoginWithKakaoTalkApp()
            } else { //카카오톡 설치 안되어있을 때
                //카카오 웹뷰로 로그인
                logStatus = await handleLoginWithKakaoAccount()
            }
        }
    }
    
    func registerUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            
            print(user.uid)
        }
    }
    
}
