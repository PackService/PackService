//
//  View.swift
//  PackService
//
//  Created by 박윤환 on 2023/02/20.
//

import Foundation
import SwiftUI

extension View {    
    //MARK: - Toast
    func toast(isShowing: Binding<Bool>) -> some View {
        self.modifier(Toast(isShowing: isShowing))
    }
    
    //MARK: - Placeholder
    func placeholder<Content: View>(
            when shouldShow: Bool,
            alignment: Alignment = .leading,
            @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
