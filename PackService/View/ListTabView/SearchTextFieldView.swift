//
//  SearchTextFieldView.swift
//  PackService
//
//  Created by 이범준 on 1/17/23.
//

import SwiftUI

struct SearchTextFieldView: View {
    @State var title: String = ""
    @State private var searchInput = ""
    var body: some View {
        VStack {
            TextField("", text: $searchInput)
        }
        .font(FontManager.body1)
        .frame(height: 52)
        .placeholder(when: searchInput.isEmpty) {
            Text(title)
                .padding(.leading, 20)
                .font(FontManager.body1)
                .foregroundColor(ColorManager.foreground2)
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
        )
        .foregroundColor(ColorManager.background2)
        .padding(.trailing, 20)
    }
}


struct SearchTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        SearchTextFieldView()
    }
}
