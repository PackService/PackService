//
//  StatusBarView.swift
//  PackService
//
//  Created by 박윤환 on 2023/01/26.
//

import SwiftUI

struct StatusBarView: View {
    
    @State var step: Int = 0
    @State var iconPos: CGFloat = .zero
    
    var body: some View {
        ZStack(alignment: .leading) {
            barBackground
            
            
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(ColorManager.primaryColor)
                    .frame(height: 32)
                    .mask(barBackground)
                    .mask(
                        GeometryReader { geo in
                            Rectangle()
                            .offset(x: 0)
                            .frame(width: 250)
                        }
                    )

            }
            icons
//                .overlay(
//                    Rectangle()
//                        .fill(ColorManager.black)
//                        .mask(barBackground)
//                )
            
        }
            
        
        
    }
}

extension StatusBarView {
    
    var icons: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 32)
                .fill(ColorManager.background2.opacity(0))
                .frame(height: 8)
            HStack {
                
                Circle()
                    .fill(ColorManager.background2.opacity(0))
                    .frame(width: 32, height: 32)
                    .overlay(
                        Image(systemName: "note.text")
                            .foregroundColor(ColorManager.background)
                    )
        
                Spacer()
                
                Circle()
                    .fill(ColorManager.background2.opacity(0))
                    .frame(width: 32, height: 32)
                    .overlay(
                        Image(systemName: "shippingbox.fill")
                            .foregroundColor(ColorManager.background)
                    )
                
                Spacer()
                
                Circle()
                    .fill(ColorManager.background2.opacity(0))
                    .frame(width: 32, height: 32)
                    .overlay(
                        Image(systemName: "box.truck.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                            .foregroundColor(ColorManager.background)
                    )
                
                Spacer()
                
                Circle()
                    .fill(ColorManager.background2.opacity(0))
                    .frame(width: 32, height: 32)
                    .overlay(
                        Image(systemName: "house.fill")
                            .foregroundColor(ColorManager.background)
                    )

            }
        }
    }
    
//    var icons: some View {
//        HStack {
//            Image(systemName: "note.text")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 17, height: 17)
//                .foregroundColor(ColorManager.background)
//
//            Spacer()
//
//            Image(systemName: "shippingbox.fill")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 20, height: 20)
//                .foregroundColor(ColorManager.background)
//
//            Spacer()
//
//            Image(systemName: "box.truck.fill")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 19, height: 19)
//                .foregroundColor(ColorManager.background)
//
//            Spacer()
//
//            Image(systemName: "house.fill")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 20, height: 20)
//                .foregroundColor(ColorManager.background)
//        }
//        .padding(.leading, 7)
//        .padding(.trailing, 6)
//
//
//    }
    
    var barBackground: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 32)
                .fill(ColorManager.background2)
                .frame(height: 8)
            HStack {
                
                Circle()
                    .fill(ColorManager.background2)
                    .frame(width: 32, height: 32)
                    .overlay(
                        Image(systemName: "note.text")
                            .foregroundColor(ColorManager.foreground2)
                    )
                       
                
                
                
                Spacer()
                
                Circle()
                    .fill(ColorManager.background2)
                    .frame(width: 32, height: 32)
                    .overlay(
                        Image(systemName: "shippingbox.fill")
                            .foregroundColor(ColorManager.foreground2)
                    )
                
                Spacer()
                
                Circle()
                    .fill(ColorManager.background2)
                    .frame(width: 32, height: 32)
                    .overlay(
                        Image(systemName: "box.truck.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                            .foregroundColor(ColorManager.foreground2)
                    )
                
                Spacer()
                
                Circle()
                    .fill(ColorManager.background2)
                    .frame(width: 32, height: 32)
                    .overlay(
                        Image(systemName: "house.fill")
                            .foregroundColor(ColorManager.foreground2)
                    )

            }
        }
    }
}

extension View {
    
    func updateIconGeoPosition(_ pos: CGFloat) -> some View {
        preference(key: IconGeometryPreferenceKey.self, value: pos)
    }
}

struct IconGeometryPreferenceKey: PreferenceKey {
    
    static var defaultValue: CGFloat = .zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct StatusBarView_Previews: PreviewProvider {
    static var previews: some View {
        StatusBarView()
    }
}
