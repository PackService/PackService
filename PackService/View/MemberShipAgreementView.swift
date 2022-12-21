//
//  MemberShipAgreementView.swift
//  PackService
//
//  Created by 이범준 on 12/21/22.
//

import SwiftUI

struct MemberShipAgreementView: View {
    @Binding var firstNaviLinkActive: Bool
    var body: some View {
        VStack{
            Text("회원가입 이용약관.")
            NavigationLink(destination: SignUpView(firstNaviLinkActive: $firstNaviLinkActive)) {
                Text("Click Here")
                    .foregroundColor(Color.white)
                    .frame(width: 100, height: 60, alignment: .center)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .fill(Color.green))
            }
        }
    }
}

struct MemberShipAgreementView_Previews: PreviewProvider {
    static var previews: some View {
        MemberShipAgreementView(firstNaviLinkActive: .constant(true))
    }
}
