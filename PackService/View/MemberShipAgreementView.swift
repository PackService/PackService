//
//  MemberShipAgreementView.swift
//  PackService
//
//  Created by 이범준 on 12/21/22.
//

import SwiftUI

struct MemberShipAgreementView: View {
    @Binding var firstNaviLinkActive: Bool
    @State var allAgree = false
    @State var ageAgree = false
    @State var serviceAgree = false
    @State var personInfoAgree = false
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("계정을")
                    .padding(.leading, 10)
                    .font(FontManager.title1)
                Text("만들어주세요")
                    .padding(.leading, 10)
                    .font(FontManager.title1)
                HStack(spacing: 20) {
                    Button(action: {
                        print(allAgree)
                        allAgree = !allAgree
                    }, label: {
                        if allAgree == false {
                            Image("EmptyCheckBox")
                                .resizable()
                                .frame(width: 30, height: 30)
                        } else {
                            Image("FullCheckBox")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                    })
                    .padding(.leading, 10)
                    .padding(.top, 20)
                    Text("전체 동의하기")
                        .padding(.top, 20)
                        .font(FontManager.body1)
                }
                HStack(spacing: 20) {
                    Button(action: {
                        ageAgree = !ageAgree
                    }, label: {
                        if ageAgree == false && allAgree == false {
                            Image("EmptyCheckBox")
                                .resizable()
                                .frame(width: 30, height: 30)
                        } else {
                            Image("FullCheckBox")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                    })
                    .padding(.leading, 10)
                    .padding(.top, 10)
                    Text("만 14세 이상입니다")
                        .padding(.top, 10)
                        .font(FontManager.body2)
                }
                HStack(spacing: 20) {
                    Button(action: {
                        serviceAgree = !serviceAgree
                    }, label: {
                        if serviceAgree == false && allAgree == false {
                            Image("EmptyCheckBox")
                                .resizable()
                                .frame(width: 30, height: 30)
                        } else {
                            Image("FullCheckBox")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                    })
                    .padding(.leading, 10)
                    .padding(.top, 10)
                    Text("서비스 이용 약관")
                        .padding(.top, 10)
                        .font(FontManager.body2)
                    NavigationLink {
                        ServiceAgreeDescriptView()
                    } label: {
                        Text("보기")
                            .underline()
                            .padding(.top, 10)
                            .font(FontManager.body2)
                    }
                }
                HStack(spacing: 20) {
                    Button(action: {
                        personInfoAgree = !personInfoAgree
                    }, label: {
                        if personInfoAgree == false && allAgree == false {
                            Image("EmptyCheckBox")
                                .resizable()
                                .frame(width: 30, height: 30)
                        } else {
                            Image("FullCheckBox")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                    })
                    .padding(.leading, 10)
                    .padding(.top, 10)
                    
                    Text("개인정보 수집 및 이용 동의")
                        .padding(.top, 10)
                        .font(FontManager.body2)
                    
                    NavigationLink {
                        PersonAgreeDescriptView()
                    } label: {
                        Text("보기")
                            .underline()
                            .padding(.top, 10)
                            .font(FontManager.body2)
                    }
                }
                Spacer()
            }
            Spacer()
        }
        VStack {
            if allAgree == true {
                NavigationLink {
                    SignUpView(firstNaviLinkActive: $firstNaviLinkActive)
                } label: {
                    Text("계정 만들기")
                }
                .buttonStyle(NormalButtonStyle())
            } else {
                Button(action: {
                    print("비활성화")
                }, label: {
                    Text("계정 만들기")
                })
                .buttonStyle(NormalButtonStyle())
            }
        }
        .navigationTitle("약관 동의")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MemberShipAgreementView_Previews: PreviewProvider {
    static var previews: some View {
        MemberShipAgreementView(firstNaviLinkActive: .constant(true))
    }
}
