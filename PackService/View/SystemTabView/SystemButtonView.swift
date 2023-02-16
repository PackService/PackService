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
                    .font(FontManager.body2)
                    .foregroundColor(ColorManager.defaultForeground)
                Spacer()
                switch buttonType {
                case .arrow:
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: 10.1, height: 17.6)
                        .foregroundColor(ColorManager.foreground2)
                        .fontWeight(.semibold)
                case .toggle:
                    Toggle("", isOn: $alarmToggle)
                        .padding(.trailing, 20)
                case .version:
                    Text(getAppVersion())
                        .font(FontManager.body2)
                        .foregroundColor(ColorManager.primaryColor)
                }
            }
            .padding(.horizontal, 20)
        }
    }
    
    func getAppVersion() -> String {
      if let info: [String: Any] = Bundle.main.infoDictionary,
          let version: String
            = info["CFBundleShortVersionString"] as? String {
            return version
      }
      return "-"
    }
}

struct SystemButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SystemButtonView(buttonType: .arrow, text: "hi")
    }
}
