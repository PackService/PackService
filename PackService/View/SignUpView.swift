//
//  SwiftUIView.swift
//  PackService
//
//  Created by 이범준 on 12/21/22.
//

import SwiftUI

struct SignUpView: View {
//    @Binding var nextSignUpScreen: Bool
    @Binding var signUpScreen: Bool
    @ObservedObject var viewModel = EmailAuthVM()
    @State var allAgree: Bool = true
    @State var emailInput: String = ""
    @State var passwordInput: String = ""
    @State var passwordCheckInput: String = ""
    
    // testAnimation 관련 함수들 -> 추후 함수화 필요
    enum TextFieldType: Hashable {
        case email
        case password
    }
    @State var isEmailValid: Bool = false
    @State var isPasswordValid: Bool = false
    @State var isSubmitted: Bool = false
    @State var isAnimated: Bool = false
    @FocusState private var focusState: TextFieldType?
    //
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                InputTextField(title: "이메일", input: $emailInput, isValid: $isEmailValid, isSubmitted: $isSubmitted, isFocused: $focusState)
                    .offset(x: !(isSubmitted && !isEmailValid) || !isAnimated ? 0 : -10)
                
                
                SecureInputTextField(title: "비밀번호", input: $passwordInput, isValid: $isPasswordValid, isSubmitted: $isSubmitted, isFocused: $focusState)
                    .offset(x: !(isSubmitted && !isPasswordValid) || !isAnimated ? 0 : -10)
                Spacer()
            }
            .onSubmit {
                toggleFocus()
            }
            Spacer()
        }
        VStack {
            Spacer()
            Button(action: {
//                nextSignUpScreen.toggle()
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
    
    
    func toggleFocus() {
        if focusState == .email {
            focusState = .password
        } else if focusState == .password {
            focusState = nil
        }
    }
    
    func validationCheck() {
        if emailInput == "abc" {
            self.isEmailValid = true
            
            if passwordInput == "1234" {
                self.isPasswordValid = true
                self.focusState = .password
                return
            }
        } else {
            self.isEmailValid = false
            self.focusState = .password
            return
        }
        
//        self.isEmailValid = false
        self.isPasswordValid = false
        self.focusState = .password
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(signUpScreen: .constant(true))
    }
}
