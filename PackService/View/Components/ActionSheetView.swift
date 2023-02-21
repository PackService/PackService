//
//  ActionSheetView.swift
//  PackService
//
//  Created by 박윤환 on 2023/02/13.
//

import SwiftUI

struct ActionSheetView: View {
    @Environment(\.dismiss) private var dismissTrackingDetailView
    @EnvironmentObject var service: LoginService
    @Binding var show: Bool
    let company: String
    let companyName: String
    let invoice: String
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if show {
                background
                
                sheetView
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(ColorManager.background)
                    )
                    .transition(.move(edge: .bottom))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut, value: show)
        
    }
}

extension ActionSheetView {
    //MARK: - Background
    var background: some View {
        Color.black.opacity(0.5)
            .ignoresSafeArea()
            .onTapGesture {
                show = false
            }
    }
    
    var sheetView: some View {
        VStack(spacing: 0) {
            ShareLink(item: "\(companyName) \(invoice)") {
                ZStack {
                    Text("공유하기")
                        .font(FontManager.body2)
                        .foregroundColor(ColorManager.defaultForeground)
                }
                .frame(height: 68)
                .frame(maxWidth: .infinity)
            }
            
            Divider()
            
            Button(role: .destructive) {
                show = false
                service.deleteTrackNumber(company: company, invoice: invoice)
                dismissTrackingDetailView()
            } label: {
                ZStack {
                    Text("삭제하기")
                        .font(FontManager.body2)
                }
                .frame(height: 68)
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 20)
    }
}

//struct ActionSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        ActionSheetView(show: .constant(true), company: "CJ 대한통운" , invoice: "555578838834")
//    }
//}
