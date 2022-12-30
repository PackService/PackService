//
//  OnBoardingView.swift
//  PackService
//
//  Created by 박윤환 on 2022/12/30.
//

import SwiftUI

struct OnBoardingView: View {
    var body: some View {        
        NavigationView {
            VStack(alignment: .center) {
                Text("내 소중한 택배의\n우당탕탕 대모험 📦")
                    .multilineTextAlignment(.center)
                    .font(FontManager.title1)
                    .lineSpacing(5)
                
                Spacer()
                
                VStack(spacing: 16) {
                    ThirdPartyButtonView(type: .apple)
                    ThirdPartyButtonView(type: .kakao)
                    ThirdPartyButtonView(type: .email)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
                
                HStack {
                    Text("이미 계정이 있나요?")
                        .foregroundColor(Color("foreground1"))
                    
                    NavigationLink {
                        LoginUIView()
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
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()        
    }
}
