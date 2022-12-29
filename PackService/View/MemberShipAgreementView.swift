//
//  MemberShipAgreementView.swift
//  PackService
//
//  Created by 이범준 on 12/21/22.
//

import SwiftUI

struct MemberShipAgreementView: View {
    @Binding var firstNaviLinkActive: Bool
    @State var isOn1 = false
    var agreementName = ["이용약관", "개인정보 처리방침"]
    var agreementContent = ["aslfjalefjaoseifjapoeifjapo iej f paosie fjpoaisje fopiasje fawefoai" , "개인정보처리방침 뭐시기저시기 ㅁ쟏러ㅔ맺댜러ㅔ매쟈더램젇"]
    var body: some View {
//        List(0...1, id: \.self) { idx in
//            DisclosureGroup {
//                HStack {
//                    VStack {
//                        ScrollView {
//                            Text(agreementContent[idx])
//                        }
//                        .frame(height: 200)
//                    }
//
//                }
//            } label: {
//                HStack {
//                    Text(agreementName[idx])
//                    Spacer()
//                }
//            }
//        }
//    }
        HStack{
            VStack(alignment: .leading, spacing: 10) {
                Text("계정을")
                    .padding(.leading, 10)
                    .padding(.top, 20)
                    .font(.custom("Pretendard-Bold", size: 30))
                Text("만들어주세요")
                    .padding(.leading, 10)
                    .font(.custom("Pretendard-Bold", size: 30))
                Button(action: {
                    print(isOn1)
                    isOn1 = !isOn1
                }, label: {
                    if isOn1 == false {
                        Image("EmptyCheckBox")
                            .resizable()
                            .frame(width: 20, height: 20)
                    } else {
                        Image("FullCheckBox")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                })
                Spacer()
            }
            Spacer()
        }
    }
}


struct MemberShipAgreementView_Previews: PreviewProvider {
    static var previews: some View {
        MemberShipAgreementView(firstNaviLinkActive: .constant(true))
    }
}
