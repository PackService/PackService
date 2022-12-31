//
//  ToggleButtonView.swift
//  PackService
//
//  Created by 이범준 on 12/31/22.
//

import SwiftUI

struct ToggleButtonView: View {
    var agree: Bool
    var body: some View {
        Image(systemName: "checkmark.circle.fill")
            .renderingMode(.template)
            .resizable()
            .frame(width: 24, height: 24)
            .foregroundColor(agree ? ColorManager.primaryColor : ColorManager.secondaryColor)
    }
}

struct ToggleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ToggleButtonView(agree: false)
            .previewLayout(.sizeThatFits)
    }
}
