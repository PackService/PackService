//
//  SwiftUIView.swift
//  PackService
//
//  Created by 이범준 on 12/21/22.
//

import SwiftUI

struct SignUpView: View {
    @Binding var nextSignUpScreen: Bool
    @Binding var signUpScreen: Bool
    @ObservedObject var viewModel = EmailAuthVM()
    @State var allAgree: Bool = true
    @State var emailInput: String = ""
    @State var passwordInput: String = ""
    @State var passwordCheckInput: String = ""
    var body: some View {
//        Color.white
//            .edgesIgnoringSafeArea(.all)
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Button(action: {
                    nextSignUpScreen.toggle()
                }, label: {
                    Image(systemName: "xmark")
                        .font(.largeTitle)
                })
                
                Text("계정을")
                    .padding(.leading, 20)
                    .font(FontManager.title1)
                Text("만들어주세요")
                    .padding(.leading, 20)
                    .font(FontManager.title1)
                
                HStack(spacing: 0) {
                    Button(action: {
                    }, label: {
                        ToggleButtonView(agree: allAgree)
                    })
                    .padding(.leading, 20)
                    .padding(.top, 25)
                    Text("전체 동의하기")
                        .padding(.top, 24)
                        .padding(.leading, 16)
                        .font(FontManager.body1)
                }
//                InputTextField(title: "사용할 이메일 주소를 입력하세요", input: $emailInput)
//                    .padding(.top, 16)
//                SecureInputTextField(title: "비밀번호", input: $passwordInput)
//                    .padding(.top, 16)
//                SecureInputTextField(title: "비밀번호를 한번 더 입력하세요", input: $passwordCheckInput)
//                    .padding(.top, 16)
                Spacer()
            }
            Spacer()
        }
        VStack {
            Spacer()
            Button(action: {
                nextSignUpScreen.toggle()
            }, label: {
                ButtonView(text: "계정 만들기")
            })
            .padding(.leading, 20)
            .padding(.trailing, 20)
        }
//        VStack {
//            TextField("이메일", text: $emailInput).keyboardType(.emailAddress).autocapitalization(.none)
//            SecureField("비밀번호", text: $passwordInput).keyboardType(.default)
//            SecureField("비밀번호 확인", text: $passwordCheckInput).keyboardType(.default)
//            Button {
//                viewModel.registerUser(email: emailInput, password: passwordInput)
//            } label: {
//                Text("등록")
//            }
//            Text("회원가입")
//            Button(action: {
//                signUpScreen = false
//            }, label: {
//                Text("Main으로 돌아가기")
//                    .foregroundColor(Color.white)
//                    .frame(width: 100, height: 60, alignment: .center)
//                    .background(RoundedRectangle(cornerRadius: 10)
//                        .fill(Color.purple))
//            })
//        }
    }
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(nextSignUpScreen: .constant(true), signUpScreen: .constant(true))
    }
}
