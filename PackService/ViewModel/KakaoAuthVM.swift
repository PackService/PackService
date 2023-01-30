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
    let db = Firestore.firestore()
    
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
                    if let token = oauthToken {
                        self.loginInFirebase()
                        continuation.resume(returning: true)
                    }
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
                    print("DEBUG: 카카오톡 로그인 Success")
                    if let token = oauthToken {
                        print("DEBUG: 카카오톡 토큰 \(token)")
                        self.loginInFirebase()
                        continuation.resume(returning: true)
                    }
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
    
    func loginInFirebase() {
        UserApi.shared.me() { user, error in
            if let error = error {
                print("DEBUG: 카카오톡 사용자 정보가져오기 에러 \(error.localizedDescription)")
            } else {
                print("DEBUG: 카카오톡 사용자 정보가져오기 success.")
//                print((user?.kakaoAccount?.email ?? "")+"1")
                // 파이어베이스 유저 생성 (이메일로 회원가입)
                Auth.auth().createUser(withEmail: ((user?.kakaoAccount?.email ?? "") + "1"),
                                       password: "\(String(describing: user?.id))") { result, error in
                    if let error = error {
                        print("DEBUG: 파이어베이스 사용자 생성 실패 \(error.localizedDescription)")
                        Auth.auth().signIn(withEmail: ((user?.kakaoAccount?.email ?? "") + "1"),
                                           password: "\(String(describing: user?.id))")
                        print("로그인되었음")
                    } else {
                        print("DEBUG: 파이어베이스 사용자 생성")
                        self.currentUser = result?.user // 이거 안하면 uid 달라짐
                        guard let user = self.currentUser else { return } // 파이어베이스 유저 객체를 가져옴
                        self.db.collection("users").document(user.uid).setData(["email": user.email ])
                    }
                }
            }
        }
    }
    
}
