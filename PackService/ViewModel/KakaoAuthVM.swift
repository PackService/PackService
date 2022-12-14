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

class KakaoAuthVM: ObservableObject {
    
    @AppStorage("log_status") var logStatus = false
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
                    // 뭐 client id 이런걸로 택배 그거 해야겄네
                }
            }
        }
    }
    
    func handleLoginWithKakaoAccount() async -> Bool {
        await withCheckedContinuation{ continuation in
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("loginWithKakaoAccount() success.")
                    _ = oauthToken
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
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
    
}
