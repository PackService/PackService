//
//  LoginUIView.swift
//  PackService
//
//  Created by 박윤환 on 2022/12/30.
//

import SwiftUI

struct LoginUIView: View {
    
    @State var emailInput: String = ""
    @State var passwordInput: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                VStack(spacing: 16) {
                    InputTextField(title: "이메일", input: $emailInput)
                    InputTextField(title: "비밀번호", input: $passwordInput)
                    
                    Button {
                        
                    } label: {
                        ButtonView(text: "로그인")
                    }
                    .padding(.top, 40)
                    
                    HStack {
                        Text("계정이 없으신가요?")
                            .foregroundColor(Color("foreground1"))
                        
                        Button {
                            
                        } label: {
                            Text("회원가입")
                                .foregroundColor(Color("primary_color"))
                                .overlay(
                                    Rectangle()
                                        .frame(height: 1)
                                        .offset(y: 2)
                                        .foregroundColor(Color("primary_color"))
                                    , alignment: .bottom)
                        }
                    }
                    .font(FontManager.body2)

                    Divider()
                        .padding(.vertical, 24)

                    Button {
                        
                    } label: {
                        ThirdPartyButtonView(type: .apple)
                    }
                    
                    Button {
                        
                    } label: {
                        ThirdPartyButtonView(type: .kakao)
                    }
                    
                }
                .padding(.horizontal, 20)
            }
            .padding(.vertical, 41)
        }
        .navigationBarHidden(true)
    }
}

struct InputTextField: View {
    
    @State var title: String
    @State var isFocused: Bool = false
    @Binding var input: String
    
    var body: some View {
        TextField("", text: $input) { status in
            if status {
                isFocused = true
            } else {
                if !input.isEmpty {
                    title = ""
                }
                isFocused = false
            }
        } onCommit: {
            isFocused = false
        }
        .font(FontManager.body1)
        .foregroundColor(ColorManager.defaultForeground)
        .padding(.horizontal, 20)
        .padding(.vertical, 18)
        .background(alignment: .leading) {
            Text(title)
                .padding(.leading, 20)
                .font(FontManager.body1)
                .foregroundColor(ColorManager.foreground2)
                .scaleEffect(isFocused ? 0 : 1.0)
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(ColorManager.primaryColor, lineWidth: 2)
                .opacity(isFocused ? 1.0 : 0.0)
                .background(isFocused ? ColorManager.background.cornerRadius(10) : ColorManager.background2.cornerRadius(10))
                .animation(Animation.easeIn(duration: 0.25), value: isFocused)
        )

    }
}

struct LoginUIView_Previews: PreviewProvider {
    
    @Binding var text: String
    
    static var previews: some View {
        LoginUIView()
    }
}
