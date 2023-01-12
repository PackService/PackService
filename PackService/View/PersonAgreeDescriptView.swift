//
//  SwiftUIView.swift
//  PackService
//
//  Created by 이범준 on 12/30/22.
//

import SwiftUI

struct PersonAgreeDescriptView: View {
    @Binding var personAgreeScreen: Bool
    var body: some View {
        Color.white
            .edgesIgnoringSafeArea(.all)
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Button(action: {
                        personAgreeScreen.toggle()
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.largeTitle)
                    })
                    Text("개인정보 뭐 서비스 이용약관")
                }
                Text("서비스 이용약관")
                    .padding(.leading, 10)
                    .padding(.top, 30)
                    .font(.custom("Pretendard-Bold", size: 17))
                Divider()
                    .padding(.leading, 10)
                Text("제 1 조(목적)")
                    .padding(.leading, 10)
                    .font(.custom("Pretendard-Medium", size: 15))
                Text("어쩌구 쩌저저저귀바을 뺒댜러ㅐㅂㅈ 댜ㅓㄹㅇ재ㅑㅂ러 댑야ㅓ ㄹ밷쟈ㅓㄹ 벵재ㅑ럳배제랴 ㅓㅇ배ㅑㄹ더 배야ㅓㄹ 밷쟈ㅓㄹ배쟈어 ㄹㅂ대ㅑ ㅓㅂ잳랴ㅓㅇㄹ 대 awefoadfiejfodijf efodijfoewijfdeoifjd e")
                    .padding(.leading, 10)
                    .font(.custom("Pretendard-Light", size: 13))
                Spacer()
            }
            Spacer()
        }
    }
}

struct NavigationPersonAgreeView: View {
    @State private var showNavigationBar = false
    var body: some View {
        VStack {
            Text("개인 정보 처리 방침입니다. \n그 목적이 있습니다.\n\n제2조 (용어의 정의) \n본 \"약관\"에서 사용하는 용어의 정의는 다음과 같습니다.\n1항\n \"택배 배송정보 제공 서비스\"란 유무선망을 통한 푸시 알림, 혹은 송장번호 조회 등의 방법을 통해 \"이용자\"가 주문한 택배의 배송 진행 상태에 관한 정보를 제공하는 \"서비스\"입니다.\n2항\n\"서비스\"는 \"스마트택배\"란 명칭의 프로그램을 통해서 제공됩니다.\n3항\n\"이용자\"란 \"스마트택배\" 프로그램을 \"이용자\" 본인" )
            Spacer()
        }
        .onDisappear(perform: {
            // 뷰가 나타날떄 수행 할 코드
            showNavigationBar = true
        })
        .toolbar(showNavigationBar ? .visible : .hidden, for: .tabBar)
        .padding(.trailing, 20)
    }
}

struct PersonAgreeDescriptView_Previews: PreviewProvider {
    static var previews: some View {
        PersonAgreeDescriptView(personAgreeScreen: .constant(true))
    }
}
