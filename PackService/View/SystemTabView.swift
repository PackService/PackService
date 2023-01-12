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

struct SystemButtonView: View {
    
    @State private var alarmToggle = true
    var buttonType: ButtonType
    var text: String
    var email: String?
    var version: String?
    
    enum ButtonType {
        case arrow
        case toggle
        case version
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(height: 48)
                .foregroundColor(ColorManager.background2)
                .cornerRadius(10)
            HStack {
                Text(text)
                    .padding(.leading, 20)
                    .font(FontManager.body2)
                Spacer()
                switch buttonType {
                case .arrow:
                    Text(email ?? "")
                        .padding(.trailing, 14.9)
                        .font(FontManager.body2)
                        .foregroundColor(ColorManager.primaryColor)
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: 10.1, height: 17.6)
                        .padding(.trailing, 26.9)
                case .toggle:
                    Toggle("", isOn: $alarmToggle)
                        .padding(.trailing, 20)
                case .version:
                    Text(version ?? "0.0.1")
                        .padding(.trailing, 20)
                        .font(FontManager.body2)
                        .foregroundColor(ColorManager.primaryColor)
                }
            }
        }
    }
}

struct SystemTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
