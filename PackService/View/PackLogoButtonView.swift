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
        VStack(spacing: 4) {
            ZStack {
                background
                
                image
            }
            
            name
        }
    }
    
}

extension PackLogoButtonView {    
    //MARK: - Background
    var background: some View {
        Circle()
            .fill(circleColor)
            .frame(width: 54, height: 54)
    }
    
    //MARK: - Image
    var image: some View {
        logoImage
            .resizable()
            .frame(width: 54, height: 54)
            .foregroundColor(.black)
    }
    
    //MARK: - Name
    var name: some View {
        Text(logoName)
            .font(FontManager.body2)
            .foregroundColor(ColorManager.defaultForeground)
    }
}

struct PackLogoButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PackLogoButtonView(circleColor: ColorManager.primaryColor, logoImage: Image("CJ_logo"), logoName: "CJ대한통운")
    }
}
