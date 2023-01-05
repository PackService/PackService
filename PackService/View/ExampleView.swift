//
//  ExampleView.swift
//  PackService
//
//  Created by 박윤환 on 2022/12/29.
//

import SwiftUI
import UIKit

struct ExampleView: View {
    
    @State var emailTextFieldText: String = ""
    @State var passwordTextFieldText: String = ""
    @State var passwordConfirmTextFieldText: String = ""
    
    var body: some View {
        
        VStack(spacing: 16) {
            InputTextFieldView(text: $emailTextFieldText, placeholder: "이메일")
                .frame(height: 62)
            
            InputTextFieldView(text: $emailTextFieldText, placeholder: "비밀번호", isSecure: true)
                .frame(height: 62)
//                .fixedSize(horizontal: true, vertical: true)
                
//                .frame(maxWidth: UIScreen.main.bounds.width)
                
            Spacer()
            Button {
                
            } label: {
                Text("클릭")
            }

        }
        .padding(.horizontal, 20)
        
    }
}

struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView()
    }
}
