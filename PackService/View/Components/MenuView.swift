//
//  MenuView.swift
//  PackService
//
//  Created by 박윤환 on 2023/01/16.
//

import SwiftUI
import UniformTypeIdentifiers

struct MenuView: View {
    @Binding var show: Bool?
    @Binding var showToast: Bool
    var tel: String
    
    //MARK: - Initializer
    init(show: Binding<Bool?> = .constant(nil), showToast: Binding<Bool>, tel: String) {
        self._show = show
        self._showToast = showToast
        self.tel = tel
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            //background
            background
            
            //menu view
            menuView
        }
    }
}

extension MenuView {
    //MARK: - Background
    var background: some View {
        Color.black.opacity(0.5)
            .ignoresSafeArea()
            .onTapGesture {
                show = false
            }
    }
    
    //MARK: - Menu View
    var menuView: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(ColorManager.background)
            .frame(width: 302, height: 204)
            .overlay(
                VStack(spacing: 0) {
                    //sms button
                    smsButton
                    
                    Divider()
                    
                    //call button
                    callButton
                    
                    Divider()
                    
                    //copy to clipboard button
                    copyToClipboardButton
                }
            
            )
    }
    
    //MARK: - SMS Button
    var smsButton: some View {
        Button {
            let sms = "sms:"
            let smsFormatted = sms + "\(tel)"
            guard let url = URL(string: smsFormatted) else { return }
            UIApplication.shared.open(url)
        } label: {
            HStack {
                Spacer()
                Text("\(tel) 메세지 보내기")
                    .font(FontManager.body2)
                    .foregroundColor(ColorManager.defaultForeground)
                Spacer()
            }
            .frame(height: 68)
        }
    }
    
    //MARK: - Call Button
    var callButton: some View {
        Button {
            let phone = "tel://"
            let phoneNumberFormatted = phone + "\(tel)".toPhoneNumber()
            guard let url = URL(string: phoneNumberFormatted) else { return }
            UIApplication.shared.open(url)
        } label: {
            HStack {
                Spacer()
                Text("\(tel) 전화하기")
                    .font(FontManager.body2)
                    .foregroundColor(ColorManager.defaultForeground)
                Spacer()
            }
            .frame(height: 68)
        }
    }
    
    //MARK: - Copy To Clipboard Button
    var copyToClipboardButton: some View {
        Button {
            UIPasteboard.general.setValue(tel, forPasteboardType: UTType.plainText.identifier)
            show = false
            showToast.toggle()
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
}

//struct MenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuView(showToast: .constant(true), tel: "01012345678")
//    }
//}
