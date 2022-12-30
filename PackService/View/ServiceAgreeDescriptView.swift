//
//  ServiceAgreeDescriptView.swift
//  PackService
//
//  Created by 이범준 on 12/30/22.
//

import SwiftUI

struct ServiceAgreeDescriptView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
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
        .navigationTitle("이용약관 동의")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

struct ServiceAgreeDescriptView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceAgreeDescriptView()
    }
}
