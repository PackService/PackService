//
//  ThirdPartyButtonView.swift
//  PackService
//
//  Created by 박윤환 on 2022/12/30.
//

import SwiftUI

//MARK: - ThirdPartyButtonView
struct ThirdPartyButtonView: View {
    var icon: Image
    var text: String
    var fgColor: Color
    var bgColor: Color
    var size: (Double, Double)
    
    init(type: LoginType) {
        switch type {
        //Apple
        case .apple:
            self.icon = Image("apple_logo")
            self.text = "Apple"
            self.fgColor = Color.white
            self.bgColor = Color.black
            self.size = (20.8, 40)
        //Kakao
        case .kakao:
            self.icon = Image("kakao_logo")
            self.text = "카카오"
            self.fgColor = Color(red: 25/255, green: 25/255, blue: 25/255)
            self.bgColor = Color("kakao_button_color")
            self.size = (20.8, 24)
        //Email
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
                .fontWeight(.semibold)
        }
        .foregroundColor(fgColor)
        .frame(maxWidth: .infinity)
        .frame(height: 52)
        .background(bgColor.cornerRadius(26))
    }
}

//struct ThirdPartyButtonView_Previews: PreviewProvider {
//    static var previews: some View {        
//        Group {
//            ThirdPartyButtonView(type: .apple)
//                .previewLayout(.sizeThatFits)
//            
//            ThirdPartyButtonView(type: .kakao)
//                .previewLayout(.sizeThatFits)
//            
//            ThirdPartyButtonView(type: .email)
//                .previewLayout(.sizeThatFits)
//        }
//    }
//}
