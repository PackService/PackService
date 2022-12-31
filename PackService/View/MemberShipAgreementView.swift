//
//  MemberShipAgreementView.swift
//  PackService
//
//  Created by 이범준 on 12/21/22.
//

import SwiftUI

struct MemberShipAgreementView: View {

    @Binding var signUpScreen: Bool
    @State var allAgree = false
    @State var ageAgree = false
    @State var serviceAgree = false
    @State var personInfoAgree = false
    var body: some View {
        Color.white
            .edgesIgnoringSafeArea(.all)
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Button(action: {
                    signUpScreen.toggle()
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
                        allAgree.toggle()
                    }, label: {
                        Image(systemName: "checkmark.circle.fill")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(allAgree ? ColorManager.primaryColor : ColorManager.secondaryColor)
                    })
                    .padding(.leading, 20)
                    .padding(.top, 25)
                    Text("전체 동의하기")
                        .padding(.top, 24)
                        .padding(.leading, 16)
                        .font(FontManager.body1)
                }
                HStack(spacing: 0) {
                    Button(action: {
                        ageAgree.toggle()
                    }, label: {
                        Image(systemName: "checkmark.circle.fill")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(allAgree ? ColorManager.primaryColor : ColorManager.secondaryColor)
                    })
                    .padding(.leading, 20)
                    .padding(.top, 16)
                    Text("만 14세 이상입니다")
                        .padding(.top, 20)
                        .padding(.leading, 16)
                        .font(FontManager.body2)
                }
                HStack(spacing: 0) {
                    Button(action: {
                        serviceAgree.toggle()
                    }, label: {
                        Image(systemName: "checkmark.circle.fill")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(ageAgree ? ColorManager.primaryColor : ColorManager.secondaryColor)
                    })
                    .padding(.leading, 20)
                    .padding(.top, 16)
                    Text("서비스 이용 약관")
                        .padding(.top, 20)
                        .padding(.leading, 16)
                        .font(FontManager.body2)
                    NavigationLink {
                        ServiceAgreeDescriptView()
                    } label: {
                        Text("보기")
                            .underline()
                            .padding(.top, 16)
                            .padding(.leading, 8)
                            .font(FontManager.body2)
                    }
                }
                HStack(spacing: 0) {
                    Button(action: {
                        personInfoAgree.toggle()
                    }, label: {
                        Image(systemName: "checkmark.circle.fill")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(ageAgree ? ColorManager.primaryColor : ColorManager.secondaryColor)
                    })
                    .padding(.leading, 20)
                    .padding(.top, 16)
                    
                    Text("개인정보 수집 및 이용 동의")
                        .padding(.top, 17)
                        .padding(.leading, 16)
                        .font(FontManager.body2)
                    
                    NavigationLink {
                        PersonAgreeDescriptView()
                    } label: {
                        Text("보기")
                            .underline()
                            .padding(.top, 10)
                            .padding(.leading, 8)
                            .font(FontManager.body2)
                    }
                }
                Spacer()
            }
            Spacer()
        }
        VStack {
            Spacer()
            ButtonView(text: "계정 만들기")
                .padding(.leading, 20)
                .padding(.trailing, 20)
        }
    }
}

struct MemberShipAgreementView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
