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
                .frame(width: 32, height: 32)
            
            Text(logoName)
                .font(FontManager.caption2)
                .foregroundColor(nameColor)
        }
        .frame(height: 32)
        .padding(.leading, 4)
        .padding(.trailing, 10)
        .background(
            Capsule()
                .fill(color)
                .overlay(Capsule().stroke(.black, lineWidth: 0.1))
        )
        
    }
}

struct ContainerButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .brightness(configuration.isPressed ? -0.1 : 0.0)
    }
}

struct CompanyCapsuleView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyCapsuleView(color: Color.red, logoImage: Image("logo_koreapost"), logoName: "대한asdfasdf통운", nameColor: Color.white)
            .previewLayout(.sizeThatFits)
    }
}
