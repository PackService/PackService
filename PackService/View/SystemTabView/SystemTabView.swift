//
//  SystemTabView.swift
//  PackService
//
//  Created by 이범준 on 1/9/23.
//

import SwiftUI

struct SystemTabView: View {
    @AppStorage("log_status") var logStatus = false
    @EnvironmentObject var emailService: EmailService
    
    var body: some View {
        NavigationView {
            VStack {
                Text("설정")
                    .font(FontManager.title2)
                VStack(spacing: 10) {
                    SystemButtonView(buttonType: .arrow, text: "계정", email: modifyEmail(emailService.currentUser?.email ?? ""))
                    NavigationLink(destination: NavigationServiceAgreeView()) {
                        SystemButtonView(buttonType: .arrow, text: "이용약관")
                    }
//                    .foregroundColor(.black)
                    NavigationLink(destination: NavigationPersonAgreeView()) {
                        SystemButtonView(buttonType: .arrow, text: "개인정보처리방침")
                    }
//                    .foregroundColor(.black)
                    SystemButtonView(buttonType: .version, text: "현재 버전")
                    
                    Button(role: .destructive, action: {
                        // logout
                        if emailService.currentUser?.email?.last == "2" {
                            emailService.logout()
                        } else if emailService.currentUser?.email?.last == "1"{
                            DispatchQueue.global(qos: .background).async {
                                try? emailService.kakaoLogout()
                            }
                            logStatus = false
                        } else {
                            emailService.logout()
                            logStatus = false
                        }
                    }, label: {
                        Text("로그아웃")
                    })
                }
                .padding(.top, 26)
                Spacer()
            }
            .padding(.horizontal, 20)
        }
    }
    
    func modifyEmail(_ email: String) -> String {
        var modifyEmail: String = ""
        if email.last == "1" || email.last == "2" {
            modifyEmail = email
            print(modifyEmail)
            return String(modifyEmail.dropLast())
        } else {
            return email
        }
    }
}

//struct SystemTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        SystemTabView()
//    }
//}

//SystemButtonView(buttonType: .arrow, text: "피드백 보내기")
//Button(action: {
//    emailService.readTrackNumber()
//    print("systemtabview : \(emailService.trackInfo)")
//}, label: {
//    Text("테스트")
//})
//Button(action: {
//    emailService.logout()
//}, label: {
//    Text("로그아웃")
//})
//                    SystemButtonView(buttonType: .toggle, text: "알림설정")
