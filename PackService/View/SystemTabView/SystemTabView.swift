//
//  SystemTabView.swift
//  PackService
//
//  Created by 이범준 on 1/9/23.
//

import SwiftUI

struct SystemTabView: View {
    @AppStorage("log_status") var logStatus = false
    @StateObject var emailAuthVM = EmailAuthVM()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("설정")
                    .font(FontManager.title2)
                VStack(spacing: 10) {
                    SystemButtonView(buttonType: .arrow, text: "계정", email: modifyEmail(emailAuthVM.currentUser?.email ?? ""))
                    SystemButtonView(buttonType: .toggle, text: "알림설정")
                    NavigationLink(destination: NavigationServiceAgreeView()) {
                        SystemButtonView(buttonType: .arrow, text: "이용약관")
                    }
                    .foregroundColor(.black)
                    NavigationLink(destination: NavigationPersonAgreeView()) {
                        SystemButtonView(buttonType: .arrow, text: "개인정보처리방침")
                    }
                    .foregroundColor(.black)
                    SystemButtonView(buttonType: .version, text: "현재 버전")
                    SystemButtonView(buttonType: .arrow, text: "피드백 보내기")
                    Button(action: {
                        emailAuthVM.logout()
//                        withAnimation(.easeInOut) {
//                            logStatus = false
//                        }
                    }, label: {
                        Text("로그아웃")
                    })
                }
                .padding(.top, 26)
                Spacer()
            }
            .padding(.trailing, 20)
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

struct SystemTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
