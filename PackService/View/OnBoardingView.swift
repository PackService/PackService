//
//  OnBoardingView.swift
//  PackService
//
//  Created by 박윤환 on 2022/12/30.
//

import SwiftUI

struct OnBoardingView: View {
    var body: some View {
        
        VStack(alignment: .center) {
            Text("내 소중한 택배의\n우당탕탕 대모험 📦")
                .multilineTextAlignment(.center)
                .font(FontManager.title1)
                .lineSpacing(5)
            
            Spacer()
            
            VStack(spacing: 16) {
                SignUpButton(type: .apple)
                    .onTapGesture {
                        // DO SOMETHING
                    }
                SignUpButton(type: .kakao)
                    .onTapGesture {
                        // DO SOMETHING
                    }
                SignUpButton(type: .email)
                    .onTapGesture {
                        // DO SOMETHING
                    }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
            
            HStack {
                Text("이미 계정이 있나요?")
                    .foregroundColor(Color("foreground1"))
                
                Button {
                    
                } label: {
                    Text("로그인")
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
        }
        .padding(.vertical, 41)        
    }
}

struct SignUpButton: View {
    
    var icon: Image
    var text: String
    var fgColor: Color
    var bgColor: Color
    var size: (Double, Double)
    
    init(type: LoginType) {
        switch type {
        case .apple:
            self.icon = Image(systemName: "apple.logo")
            self.text = "Apple"
            self.fgColor = Color.white
            self.bgColor = Color.black
            self.size = (18, 22)
        case .kakao:
            self.icon = Image("kakao_logo")
            self.text = "카카오"
            self.fgColor = Color(red: 25/255, green: 25/255, blue: 25/255)
            self.bgColor = Color("kakao_button_color")
            self.size = (20.8, 24)
        case .email:
            self.icon = Image(systemName: "envelope.fill")
            self.text = "이메일"
            self.fgColor = Color(red: 33/255, green: 37/255, blue: 41/255)
            self.bgColor = Color("email_button_color")
            self.size = (20.8, 16.3)
        }
    }
    
    enum LoginType {
        case apple
        case kakao
        case email
    }
    
    var body: some View {
        HStack(spacing: 10) {
            icon
                .resizable()
                .scaledToFill()
                .frame(width: size.0, height: size.1)
            Text(text + "로 계속하기")
                .font(FontManager.title2)
//                .font(.system(size: 17))
                .fontWeight(.semibold)
        }
        .foregroundColor(fgColor)
        .frame(maxWidth: .infinity)
        .frame(height: 52)
        .background(bgColor.cornerRadius(26))
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
        
        Group {
            SignUpButton(type: .apple)
                .previewLayout(.sizeThatFits)
            
            SignUpButton(type: .kakao)
                .previewLayout(.sizeThatFits)
            
            SignUpButton(type: .email)
                .previewLayout(.sizeThatFits)
        }
        
    }
}
