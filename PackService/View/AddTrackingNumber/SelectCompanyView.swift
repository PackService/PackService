//
//  SelectCompanyView.swift
//  PackService
//
//  Created by 이범준 on 1/8/23.
//

import SwiftUI

struct SelectCompanyView: View {
    
    @StateObject var companyVM = CompanyService()
    @Environment(\.presentationMode) var presentationMode
    @Binding var show: Bool
    @Binding var text: String?
    @Binding var selected: String?
    let names = ["04", "46", "22", "13", "12", "21", "41", "24", "05", "32", "11", "01", "23", "06", "08", "37", "53", "25", "14", "26"]
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 0, alignment: nil),
        GridItem(.flexible(), spacing: 0, alignment: nil),
        GridItem(.flexible(), spacing: nil, alignment: nil)
    ]
    
    var body: some View {        
        ZStack {
            background
            
            VStack {
                header
                
                companyGrid
                
                Spacer()
            }
        }
    }
    
}

extension SelectCompanyView {
    
    //MARK: - Background
    var background: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(ColorManager.background)
            .ignoresSafeArea(.all, edges: .bottom)
    }
    
    //MARK: - Header
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
//                        presentationMode.wrappedValue.dismiss()
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

    //MARK: - Company Grid
    var companyGrid: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 24) {
                ForEach(companyVM.allCompanies.company) { company in
                    let logo = LogoType(rawValue: company.id) ?? LogoType.etc
                    Button {
                        text = company.name
                        selected = company.id
                        show = false
//                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        PackLogoButtonView(circleColor: .gray, logoImage: logo.logo.image, logoName: company.name)
                    }
                }
            }
        }
    }
}

struct SelectCompanyView_Previews: PreviewProvider {
    static var previews: some View {
        SelectCompanyView(show: .constant(true), text: .constant("CJ 대한통운"), selected: .constant("04"))
//        HeaderView()
//            .previewLayout(.sizeThatFits)
    }
}
