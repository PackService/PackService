//
//  MenuView.swift
//  PackService
//
//  Created by 박윤환 on 2023/01/16.
//

import SwiftUI

struct MenuView: View {
    @Binding var show: Bool?
    
    init(show: Binding<Bool?> = .constant(nil)) {
        self._show = show
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    show = false
                }
            
            RoundedRectangle(cornerRadius: 16)
                .fill(ColorManager.background)
                .frame(width: 302, height: 204)
                .overlay(
                    VStack(spacing: 0) {
                        Button {
                            
                        } label: {
                            HStack {
                                Spacer()
                                Text("010-1234-5678 메세지 보내기")
                                    .font(FontManager.body2)
                                    .foregroundColor(ColorManager.defaultForeground)
                                Spacer()
                            }
                            .frame(height: 68)
                        }
                        
                        Divider()
                        
                        Button {
                            
                        } label: {
                            HStack {
                                Spacer()
                                Text("010-1234-5678 전화하기")
                                    .font(FontManager.body2)
                                    .foregroundColor(ColorManager.defaultForeground)
                                Spacer()
                            }
                            .frame(height: 68)
                        }
                        
                        Divider()
                        
                        Button {
                            
                        } label: {
                            HStack {
                                Spacer()
                                Text("기사님 번호 클립보드에 저장")
                                    .font(FontManager.body2)
                                    .foregroundColor(ColorManager.defaultForeground)
                                Spacer()
                            }
                            .frame(height: 68)
                        }
                    }
                
                )
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
