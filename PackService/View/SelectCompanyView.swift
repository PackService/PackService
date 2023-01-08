//
//  SelectCompanyView.swift
//  PackService
//
//  Created by 이범준 on 1/8/23.
//

import SwiftUI

struct SelectCompanyView: View { // 택배사 이미지 사용법을 위한 view
    var body: some View {
        VStack {
            HStack {
                PackLogoButtonView(circleColor: .gray, logoImage: Image("cj_logo"), logoName: "CJ대한통운")
                PackLogoButtonView(circleColor: .gray, logoImage: Image("cj_logo"), logoName: "CJ대한통운")
                PackLogoButtonView(circleColor: .gray, logoImage: Image("cj_logo"), logoName: "CJ대한통운")
            }
            .padding(.trailing, 43)
            .padding(.leading, 43)
        }
    }
}

struct SelectCompanyView_Previews: PreviewProvider {
    static var previews: some View {
        SelectCompanyView()
    }
}
