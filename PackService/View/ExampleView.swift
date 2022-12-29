//
//  ExampleView.swift
//  PackService
//
//  Created by 박윤환 on 2022/12/29.
//

import SwiftUI

struct ExampleView: View {
    
    @State var emailTextFieldText: String = ""
    @State var passwordTextFieldText: String = ""
    @State var passwordConfirmTextFieldText: String = ""
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("계정을\n만들어주세요")
            
            TextField("사용할 이메일 주소를 입력하세요", text: $emailTextFieldText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("비밀번호", text: $passwordTextFieldText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("비밀번호를 한번 더 입력하세요", text: $passwordConfirmTextFieldText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Spacer()
            
            Button {
                
            } label: {
                Text("계정 만들기")
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        Color.purple
                    )
                    .cornerRadius(30)
                    
                    
            }
            .padding(.horizontal, 20)

        }
        
    }
}

struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView()
    }
}
