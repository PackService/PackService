//
//  packLogoButtonView.swift
//  PackService
//
//  Created by 이범준 on 1/8/23.
//

import SwiftUI

struct PackLogoButtonView: View {
    var circleColor: Color
    var logoImage: Image
    var logoName: String
    
    var body: some View {
        VStack {
            ZStack {
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 54, height: 54)
                    .foregroundColor(circleColor)
                logoImage
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.black)
            }
            Text(logoName)
                .font(FontManager.body2)
        }
    }
}

struct PackLogoButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PackLogoButtonView(circleColor: ColorManager.primaryColor, logoImage: Image(systemName: "house"), logoName: "CJ대한통운")
    }
}
