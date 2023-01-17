//
//  SystemButtonView.swift
//  PackService
//
//  Created by 이범준 on 1/17/23.
//

import SwiftUI

struct SystemButtonView: View {
    
    @State private var alarmToggle = true
    var buttonType: ButtonType
    var text: String
    var email: String?
    var version: String?
    
    enum ButtonType {
        case arrow
        case toggle
        case version
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(height: 48)
                .foregroundColor(ColorManager.background2)
                .cornerRadius(10)
            HStack {
                Text(text)
                    .padding(.leading, 20)
                    .font(FontManager.body2)
                Spacer()
                switch buttonType {
                case .arrow:
                    Text(email ?? "")
                        .padding(.trailing, 14.9)
                        .font(FontManager.body2)
                        .foregroundColor(ColorManager.primaryColor)
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: 10.1, height: 17.6)
                        .padding(.trailing, 26.9)
                case .toggle:
                    Toggle("", isOn: $alarmToggle)
                        .padding(.trailing, 20)
                case .version:
                    Text(version ?? "0.0.1")
                        .padding(.trailing, 20)
                        .font(FontManager.body2)
                        .foregroundColor(ColorManager.primaryColor)
                }
            }
        }
    }
}

struct SystemButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SystemButtonView(buttonType: .toggle, text: "hi")
    }
}
