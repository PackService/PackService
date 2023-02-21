//
//  packLogoButtonView.swift
//  PackService
//
//  Created by 이범준 on 1/8/23.
//

import SwiftUI

//MARK: - CompanyLogoButtonView
struct CompanyLogoButtonView: View {
    var bgColor: Color
    var logo: Image
    var title: String
    
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

extension CompanyLogoButtonView {    
    //MARK: - Background
    var background: some View {
        Circle()
            .fill(bgColor)
            .frame(width: 54, height: 54)
    }
    
    //MARK: - Image
    var image: some View {
        logo
            .resizable()
            .frame(width: 54, height: 54)
            .foregroundColor(.black)
    }
    
    //MARK: - Name
    var name: some View {
        Text(title)
            .font(FontManager.body2)
            .foregroundColor(ColorManager.defaultForeground)
    }
}

struct PackLogoButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyLogoButtonView(bgColor: ColorManager.primaryColor, logo: Image("CJ_logo"), title: "CJ대한통운")
    }
}
