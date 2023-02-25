//
//  AccountView.swift
//  PackService
//
//  Created by 박윤환 on 2023/02/21.
//

import SwiftUI

//MARK: - AccountView
struct AccountView: View {
    @EnvironmentObject var service: LoginService
    @State var showDeleteAllDataAlert: Bool = false
    @State var showDeleteAccountAlert: Bool = false
    
    var body: some View {
        VStack {
            Button(role: .destructive) {
                showDeleteAllDataAlert = true
            } label: {
                ZStack {
                    Rectangle()
                        .frame(height: 48)
                        .foregroundColor(ColorManager.background2)
                        .cornerRadius(10)
                    HStack {
                        Text("모든 데이터 삭제하기")
                            .font(FontManager.body2)
                            .foregroundColor(ColorManager.defaultForeground)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                }
            }
            .alert("데이터 삭제하기", isPresented: $showDeleteAllDataAlert) {
                Button("취소", role: .cancel) {}
                Button("삭제", role: .destructive) {
                    service.deleteAllData()
                }
            } message: {
                Text("모든 데이터를 삭제하시겠습니까?")
            }
            
            Button(role: .destructive) {
                showDeleteAccountAlert = true
            } label: {
                ZStack {
                    Rectangle()
                        .frame(height: 48)
                        .foregroundColor(ColorManager.background2)
                        .cornerRadius(10)
                    HStack {
                        Text("회원 탈퇴")
                            .font(FontManager.body2)
                            .foregroundColor(ColorManager.negativeColor)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                }
            }
            .alert("회원 탈퇴", isPresented: $showDeleteAccountAlert) {
                Button("취소", role: .cancel) {}
                Button("탈퇴", role: .destructive) {
                    service.deleteUser()
                    service.logStatus = false
                }
            } message: {
                Text("회원탈퇴를 하시겠습니까?")
            }

            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
}

//struct AccountView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountView()
//    }
//}
