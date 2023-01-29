//
//  SearchTextFieldView.swift
//  PackService
//
//  Created by 이범준 on 1/17/23.
//

import SwiftUI

struct SearchTextFieldView: View {
    @State var title: String = ""
    @Binding var searchInput: String
    var isFocused: FocusState<Bool>.Binding
    
    var body: some View {
        TextField("", text: $searchInput)
            .focused(isFocused)
            .font(FontManager.body1)
            .foregroundColor(ColorManager.defaultForeground)
            .tint(ColorManager.primaryColor)
            .padding(.horizontal, 20)
            .padding(.vertical, 13)
            .frame(height: 52)
            .placeholder(when: searchInput.isEmpty) {
                Text(title)
                    .padding(.leading, 20)
                    .font(FontManager.body1)
                    .foregroundColor(ColorManager.foreground2)
            }
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(ColorManager.primaryColor, lineWidth: 2)
                    .opacity(isFocused.wrappedValue == true ? 1.0 : 0.0)
                    .background(isFocused.wrappedValue == true ? ColorManager.background.cornerRadius(10) : ColorManager.background2.cornerRadius(10))
                    .animation(Animation.easeIn(duration: 0.25), value: isFocused.wrappedValue == true)
            )
        
    }
}

//
//struct SearchTextFieldView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchTextFieldView(isFocused: .constant(true))
//    }
//}
