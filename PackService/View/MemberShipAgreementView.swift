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
    var agreementContent = ["aslfjalefjaoseifjapoeifjapo efjaosifjapweoifj asdoifj apweoifj aspdofijwpe ofijqwdpofij qwepoifj apsoijfeapsoeifj apoeisjf aposeifj apsoeifj apsoeifjaopsiej fpaosiej fpaoisejf poasiejdfpoasiej paosie fjpoaisje fopiasje fawefoaiofij qwepoifj apsoijfeapsoeifj apoeisjf aposeifj apsoeifj apsoeifjaopsiej fpaosiej fpaoisejf poasiejdfpoasiej paosie fjpoaisje fopiasje fawefoaiofij qwepoifj apsoijfeapsoeifj apoeisjf aposeifj apsoeifj apsoeifjaopsiej fpaosiej fpaoisejf poasiejdfpoasiej paosie fjpoaisje fopiasje fawefoaiofij qwepoifj apsoijfeapsoeifj apoeisjf aposeifj apsoeifj apsoeifjaopsiej fpaosiej fpaoisejf poasiejdfpoasiej paosie fjpoaisje fopiasje fawefoaiofij qwepoifj apsoijfeapsoeifj apoeisjf aposeifj apsoeifj apsoeifjaopsiej fpaosiej fpaoisejf poasiejdfpoasiej paosie fjpoaisje fopiasje fawefoaiofij qwepoifj apsoijfeapsoeifj apoeisjf aposeifj apsoeifj apsoeifjaopsiej fpaosiej fpaoisejf poasiejdfpoasiej paosie fjpoaisje fopiasje fawefoaiofij qwepoifj apsoijfeapsoeifj apoeisjf aposeifj apsoeifj apsoeifjaopsiej fpaosiej fpaoisejf poasiejdfpoasiej paosie fjpoaisje fopiasje fawefoaiofij qwepoifj apsoijfeapsoeifj apoeisjf aposeifj apsoeifj apsoeifjaopsiej fpaosiej fpaoisejf poasiejdfpoasiej paosie fjpoaisje fopiasje fawefoaiofij qwepoifj apsoijfeapsoeifj apoeisjf aposeifj apsoeifj apsoeifjaopsiej fpaosiej fpaoisejf poasiejdfpoasiej paosie fjpoaisje fopiasje fawefoaiofij qwepoifj apsoijfeapsoeifj apoeisjf aposeifj apsoeifj apsoeifjaopsiej fpaosiej fpaoisejf poasiejdfpoasiej paosie fjpoaisje fopiasje fawefoai" , "개인정보처리방침 뭐시기저시기 ㅁ애랴멎대랴ㅓ메ㅐ쟈ㅓ레ㅐ먀젇레ㅐ머ㅑ애ㅔ랴멎대ㅔ랴ㅓㅁ제ㅐ댜러메재댜러메재댜러메재댜러메ㅐㄴ야ㅓㄹ매댜ㅓ래ㅑㅓㄷ매랴ㅐ먀젇래먀젇레매ㅑㅈ더레매쟈더레매쟏러ㅔ매쟏러ㅔ맺댜러ㅔ매쟈더램젇"]
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
