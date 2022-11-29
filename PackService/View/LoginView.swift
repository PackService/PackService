//
//  LoginView.swift
//  PackService
//
//  Created by 이범준 on 11/28/22.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var kakaoAuthVM: KaKaoAuthVM = KaKaoAuthVM()
    let loginStatusInfo: (Bool) -> String = { isLoggedIn in
        return isLoggedIn ? "로그인 상태" : "로그아웃 상태"
    }
    
    var body: some View {
        
        VStack(spacing: 20) {
            Text(loginStatusInfo(kakaoAuthVM.isLoggedIn))
                .padding()
            Button("카카오 로그인22222", action: {
                kakaoAuthVM.handleKakaoLogin()
            })
            Button("카카오 로그아웃", action: {
                kakaoAuthVM.kakaoLogout()
            })
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
