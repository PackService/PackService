//
//  SelectCompanyView.swift
//  PackService
//
//  Created by 이범준 on 1/8/23.
//

import SwiftUI

struct SelectCompanyView: View { // 택배사 이미지 사용법을 위한 view
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var show: Bool
    @Binding var selected: String?
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 0, alignment: nil),
        GridItem(.flexible(), spacing: 0, alignment: nil),
        GridItem(.flexible(), spacing: nil, alignment: nil)
    ]
    
    var body: some View {        
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(ColorManager.background)
                .ignoresSafeArea(.all, edges: .bottom)
            
            VStack {
                header
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 24) {
                        ForEach(1..<16) { index in
                            Button {
                                selected = "\(index)"
                                show = false
                            } label: {
                                PackLogoButtonView(circleColor: .gray, logoImage: Image("CJ_logo"), logoName: "CJ대한통운")
                            }

                        }
                    }
//                    .padding(.top, 16)
                }
                Spacer()
            }
            
        }
        

//                PackLogoButtonView(circleColor: .gray, logoImage: Image("cj_logo"), logoName: "CJ대한통운")

    }
}

extension SelectCompanyView {
    var header: some View {
        ZStack {
            Color.red.opacity(0)
                .frame(height: 55)
            
            Group {
                Text("택배사 선택")
                    .font(FontManager.body2)
                    .foregroundColor(ColorManager.defaultForeground)
                
                ZStack(alignment: .trailing) {
                    Color.yellow.opacity(0)
                        .frame(height: 55)
                    
                    Button {
                        show = false
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("취소")
                            .font(FontManager.body2)
                            .foregroundColor(ColorManager.defaultForeground)
                    }
                    .padding(.trailing, 16)

                }
            }
            
        }
        
    }
}

struct SelectCompanyView_Previews: PreviewProvider {
    static var previews: some View {
        SelectCompanyView(show: .constant(true), selected: .constant("CJ 대한통운"))
//        HeaderView()
//            .previewLayout(.sizeThatFits)
    }
}
