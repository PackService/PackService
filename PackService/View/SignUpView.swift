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
//                InputTextField2(title: "이메일", input: $emailInput, isValid: $isEmailValid, isSubmitted: $isSubmitted, isFocused2: $focusState)
//                    .offset(x: !(isSubmitted && !isEmailValid) || !isAnimated ? 0 : -10)
//
//
//                SecureInputTextField2(title: "비밀번호", input: $passwordInput, isValid: $isPasswordValid, isSubmitted: $isSubmitted, isFocused: $focusState)
//                    .offset(x: !(isSubmitted && !isPasswordValid) || !isAnimated ? 0 : -10)
                Spacer()
            }
            .onSubmit {
//                toggleFocus()
            }
            Spacer()
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
//
//struct InputTextField2: View {
//
//    @State var title: String = ""
////    @FocusState var isFocused: Bool
//    @Binding var input: String
//    @Binding var isValid: Bool
//    @Binding var isSubmitted: Bool
//    var isFocused2: FocusState<SignUpView.TextFieldType?>.Binding
//
//    var body: some View {
//        TextField("", text: $input)
//            .focused(isFocused2, equals: .email)
//            .submitLabel(.next)
//            .font(FontManager.body1)
//            .foregroundColor(ColorManager.defaultForeground)
//            .tint(ColorManager.primaryColor)
//            .padding(.horizontal, 20)
//            .padding(.vertical, 18)
//            .placeholder(when: input.isEmpty) {
//                Text(title)
//                    .padding(.leading, 20)
//                    .font(FontManager.body1)
//                    .foregroundColor(ColorManager.foreground2)
//            }
//            .background(
//                RoundedRectangle(cornerRadius: 10)
//                    .strokeBorder(!(isSubmitted && !isValid) ? ColorManager.primaryColor : ColorManager.negativeColor, lineWidth: 2)
//                    .opacity(self.isFocused2.wrappedValue == .email ? 1.0 : 0.0)
//                    .background(self.isFocused2.wrappedValue == .email ? ColorManager.background.cornerRadius(10) : ColorManager.background2.cornerRadius(10))
//                    .animation(Animation.easeIn(duration: 0.25), value: self.isFocused2.wrappedValue == .email)
//            )
//
//    }
//}
//
//struct SecureInputTextField2: View {
//
//    @State var title: String = ""
////    @FocusState private var isFocused: Bool
//    @Binding var input: String
//    @Binding var isValid: Bool
//    @Binding var isSubmitted: Bool
//    var isFocused: FocusState<SignUpView.TextFieldType?>.Binding
//
//    var body: some View {
//        SecureField("", text: $input)
//            .focused(isFocused, equals: .password)
//            .submitLabel(.return)
//            .font(FontManager.body1)
//            .foregroundColor(ColorManager.defaultForeground)
//            .tint(ColorManager.primaryColor)
//            .padding(.horizontal, 20)
//            .padding(.vertical, 18)
//            .placeholder(when: input.isEmpty) {
//                Text(title)
//                    .padding(.leading, 20)
//                    .font(FontManager.body1)
//                    .foregroundColor(ColorManager.foreground2)
//            }
//            .background(
//                RoundedRectangle(cornerRadius: 10)
//                    .strokeBorder(!(isSubmitted && !isValid) ? ColorManager.primaryColor : ColorManager.negativeColor, lineWidth: 2)
//                    .opacity(isFocused.wrappedValue == .password ? 1.0 : 0.0)
//                    .background(isFocused.wrappedValue == .password ? ColorManager.background.cornerRadius(10) : ColorManager.background2.cornerRadius(10))
//                    .animation(Animation.easeIn(duration: 0.25), value: isFocused.wrappedValue == .password)
//            )
//    }
//}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(signUpScreen: .constant(true))
    }
}
