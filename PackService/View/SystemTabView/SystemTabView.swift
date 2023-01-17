//
//  SystemTabView.swift
//  PackService
//
//  Created by 이범준 on 1/9/23.
//

import SwiftUI

struct SystemTabView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("설정")
                    .font(FontManager.title2)
                VStack(spacing: 10) {
                    SystemButtonView(buttonType: .arrow, text: "계정", email: "abc@naver.com")
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
                }
                .padding(.top, 26)
                Spacer()
            }
            .padding(.trailing, 20)
        }
    }
}

struct SystemTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}