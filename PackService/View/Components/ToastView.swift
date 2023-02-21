//
//  ToastView.swift
//  PackService
//
//  Created by 박윤환 on 2023/01/24.
//

import SwiftUI

//MARK: - Toast
struct Toast: ViewModifier {
    //duration
    static let short: TimeInterval = 2
    static let long: TimeInterval = 3.5

    @Binding var isShowing: Bool

    func body(content: Content) -> some View {
        ZStack {
          content
          toastView
        }
    }

    private var toastView: some View {
        VStack {
          Spacer()
          if isShowing {
            Group {
              Text("클립보드에 복사되었습니다")
                .multilineTextAlignment(.center)
                .font(FontManager.body2)
                .foregroundColor(ColorManager.background2)
                .padding(8)
            }
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .background(.ultraThinMaterial)
                    .frame(width: UIScreen.main.bounds.width - 60, height: 55)
            )
            .onTapGesture {
              isShowing = false
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + Toast.short) {
                    isShowing = false
                }
            }
          }
        }
        .animation(Animation.easeInOut(duration: 0.3), value: isShowing)
        .transition(.opacity)
    }
}
