//
//  MemberShipAgreementView.swift
//  PackService
//
//  Created by 이범준 on 12/21/22.
//

import SwiftUI

struct MemberShipAgreementView: View {
    @Binding var firstNaviLinkActive: Bool
    var agreementName = ["이용약관", "개인정보 처리방침"]
    var agreementContent = ["aslfjalefjaoseifjapoeifjapo iej f paosie fjpoaisje fopiasje fawefoai" , "개인정보처리방침 뭐시기저시기 ㅁ쟏러ㅔ맺댜러ㅔ매쟈더램젇"]
    var body: some View {
        List(0...1, id: \.self) { idx in
            DisclosureGroup {
                HStack {
                    VStack {
                        ScrollView {
                            Text(agreementContent[idx])
                        }
                        .frame(height: 200)
                    }
                }
            } label: {
                HStack {
                    Text(agreementName[idx])
                    Spacer()
                }
            }
        }
        NavigationLink(destination: SignUpView(firstNaviLinkActive: $firstNaviLinkActive)) {
            Text("동의합니다.")
        }
    }
}

struct MemberShipAgreementView_Previews: PreviewProvider {
    static var previews: some View {
        MemberShipAgreementView(firstNaviLinkActive: .constant(true))
    }
}
