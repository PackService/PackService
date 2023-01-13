//
//  CompanyCapsuleView.swift
//  PackService
//
//  Created by 박윤환 on 2023/01/13.
//

import SwiftUI

struct CompanyCapsuleView: View {
    
    var color: Color
    var logoImage: Image
    var logoName: String
    var nameColor: Color
    
    @State var capsuleSize: CGFloat = .zero
    
    var body: some View {
        HStack(spacing: 4) {
            logoImage
                .resizable()
                .frame(width: 19, height: 16.3)
            
            Text(logoName)
                .font(FontManager.caption2)
                .foregroundColor(nameColor)
        }
        .frame(height: 32)
        .padding(.horizontal, 10)
        .background(
            Capsule()
                .fill(color)
        )
        
    }
}

struct CompanyCapsuleView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyCapsuleView(color: Color.red, logoImage: Image("CJ_logo"), logoName: "대한asdfasdf통운", nameColor: Color.white)
            .previewLayout(.sizeThatFits)
    }
}
