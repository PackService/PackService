//
//  SwiftUIView.swift
//  PackService
//
//  Created by 이범준 on 12/21/22.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel = EmailAuthVM()
    @Binding var firstNaviLinkActive: Bool
    @State var emailInput: String = ""
    @State var passwordInput: String = ""
    var body: some View {
        VStack{
            TextField("이메일", text: $emailInput).keyboardType(.emailAddress).autocapitalization(.none)
            SecureField("비밀번호", text: $passwordInput).keyboardType(.default)
            SecureField("비밀번호 확인", text: $passwordInput).keyboardType(.default)
            Button {
                viewModel.registerUser(email: emailInput, password: passwordInput)
            } label: {
                Text("등록")
            }
            Text("회원가입")
            Button(action: {
                firstNaviLinkActive = false
            }, label: {
                Text("Main으로 돌아가기")
                    .foregroundColor(Color.white)
                    .frame(width: 100, height: 60, alignment: .center)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .fill(Color.purple))
            })
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(firstNaviLinkActive: .constant(true))
    }
}
