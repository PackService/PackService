//
//  MemberShipAgreementView.swift
//  PackService
//
//  Created by 이범준 on 12/21/22.
//

import SwiftUI

struct MemberShipAgreementView: View {
    @Binding var firstNaviLinkActive: Bool
    @State var isToggleOn: Bool = true
    var item = "aslfjalefjaoseifjapoeifjapo efjaosifjapweoifj asdoifj apweoifj aspdofijwpe ofijqwdpofij qwepoifj apsoijfeapsoeifj apoeisjf aposeifj apsoeifj apsoeifjaopsiej fpaosiej fpaoisejf poasiejdfpoasiej paosie fjpoaisje fopiasje fawefoaiofij qwepoifj apsoijfeapsoeifj apoeisjf aposeifj apsoeifj apsoeifjaopsiej fpaosiej fpaoisejf poasiejdfpoasiej paosie fjpoaisje fopiasje fawefoaiofij qwepoifj apsoijfeapsoeifj apoeisjf aposeifj apsoeifj apsoeifjaopsiej fpaosiej fpaoisejf poasiejdfpoasiej paosie fjpoaisje fopiasje fawefoaiofij qwepoifj apsoijfeapsoeifj apoeisjf aposeifj apsoeifj apsoeifjaopsiej fpaosiej fpaoisejf poasiejdfpoasiej paosie fjpoaisje fopiasje fawefoaiofij qwepoifj apsoijfeapsoeifj apoeisjf aposeifj apsoeifj apsoeifjaopsiej fpaosiej fpaoisejf poasiejdfpoasiej paosie fjpoaisje fopiasje fawefoaiofij qwepoifj apsoijfeapsoeifj apoeisjf aposeifj apsoeifj apsoeifjaopsiej fpaosiej fpaoisejf poasiejdfpoasiej paosie fjpoaisje fopiasje fawefoaiofij qwepoifj apsoijfeapsoeifj apoeisjf aposeifj apsoeifj apsoeifjaopsiej fpaosiej fpaoisejf poasiejdfpoasiej paosie fjpoaisje fopiasje fawefoaiofij qwepoifj apsoijfeapsoeifj apoeisjf aposeifj apsoeifj apsoeifjaopsiej fpaosiej fpaoisejf poasiejdfpoasiej paosie fjpoaisje fopiasje fawefoaiofij qwepoifj apsoijfeapsoeifj apoeisjf aposeifj apsoeifj apsoeifjaopsiej fpaosiej fpaoisejf poasiejdfpoasiej paosie fjpoaisje fopiasje fawefoaiofij qwepoifj apsoijfeapsoeifj apoeisjf aposeifj apsoeifj apsoeifjaopsiej fpaosiej fpaoisejf poasiejdfpoasiej paosie fjpoaisje fopiasje fawefoai"
    var body: some View {
        
        VStack(spacing: 10) {
            Text("이용약관")
                .frame(alignment:.trailing)
            GroupBox {
                ScrollView(.vertical, showsIndicators: true) {
                    Text(item)
                        .font(.footnote)
                }
                .frame(height: 100)
            }
            .padding(20)
            NavigationLink(destination: SignUpView(firstNaviLinkActive: $firstNaviLinkActive)) {
                Text("Click Here")
            }
        }
        
    }
}

struct MemberShipAgreementView_Previews: PreviewProvider {
    static var previews: some View {
        MemberShipAgreementView(firstNaviLinkActive: .constant(true))
    }
}
