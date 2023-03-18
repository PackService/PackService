//
//  SystemTabView.swift
//  PackService
//
//  Created by 이범준 on 1/9/23.
//

import SwiftUI

//MARK: - SettingsTabView
struct SettingsTabView: View {
    @AppStorage("log_status") var logStatus = false
    @EnvironmentObject var service: LoginService
    @State var showLogoutAlert: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("설정")
                    .font(FontManager.title2)
                VStack(spacing: 10) {
                    NavigationLink {
                        AccountView()
                            .navigationTitle("계정")
                            .environmentObject(service)
                    } label: {
                        SettingsView(buttonType: .arrow, text: "계정", email: modifyEmail(service.currentUser?.email ?? ""))
                    }
                    
                    NavigationLink(destination: NavigationTermsOfServiceView()) {
                        SettingsView(buttonType: .arrow, text: "이용약관")
                    }

                    NavigationLink(destination: NavigationPrivacyPolicyView()) {
                        SettingsView(buttonType: .arrow, text: "개인정보처리방침")
                    }

                    SettingsView(buttonType: .version, text: "현재 버전")
                    
                    //Logout Button
                    Button(role: .destructive, action: {
                        showLogoutAlert = true
                    }, label: {
                        Text("로그아웃")
                    })
                    .padding(.top, 8)
                    .alert("로그아웃", isPresented: $showLogoutAlert) {
                        Button("취소", role: .cancel) {}
                        Button("로그아웃", role: .destructive) {
                            if service.currentUser?.email?.last == "2" {
                                service.logout()
                            } else if service.currentUser?.email?.last == "1"{
                                DispatchQueue.global(qos: .background).async {
                                    try? service.kakaoLogout()
                                }
                                logStatus = false
                            } else {
                                service.logout()
                                logStatus = false
                            }
                        }
                    } message: {
                        Text("로그아웃 하시겠습니까?")
                    }
                }
                .padding(.top, 26)
                
                Spacer()
            }
            .padding(.horizontal, 20)
        }
    }
    
    //MARK: - modifyEmail(_:)
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
