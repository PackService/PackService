//
//  TrackingPositionListCellView.swift
//  PackService
//
//  Created by 박윤환 on 2023/01/16.
//

import SwiftUI

//MARK: - List Cell
struct TrackingPositionListCellView: View {
    
    var status: String
    var position: String
    var deliveryMan: String? = nil
    var time: String
    var date: String
    var isCurrent: Bool = false
    @State var scale = 1.0
    
    var body: some View {
        HStack(alignment: .top) {
            Circle()
                .fill(ColorManager.primaryColor)
                .frame(width: 8, height: 8, alignment: .top)
                .scaleEffect(scale)
                .padding(.top, 8)
                .padding(.horizontal, 4)
                .onAppear {
                    if isCurrent {
                        withAnimation(Animation.easeIn(duration: 0.7).repeatForever(autoreverses: true)) {
                            scale = 1.3
                        }
                    }
                }
            
            leftColumn
            
            Spacer()
            
            rightColumn
        }
        
    }
}

extension TrackingPositionListCellView {
    var leftColumn: some View {
        VStack(alignment: .leading) {
            Text(status)
                .font(FontManager.body2)
                .foregroundColor(ColorManager.defaultForeground)
            HStack {
                Text(position)
                    
                if let deliveryMan = deliveryMan {
                    Text("(\(deliveryMan))" )
                }
            }
            .font(FontManager.caption1)
            .foregroundColor(ColorManager.foreground1)
            
        }
    }
    
    var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text(time)
                .font(FontManager.body2)
                .foregroundColor(ColorManager.defaultForeground)
            Text(date)
                .font(FontManager.caption1)
                .foregroundColor(ColorManager.foreground1)
        }
    }
}

extension View {
    
    func updateListGeoSize(_ size: CGSize) -> some View {
        preference(key: ListGeometryPreferenceKey.self, value: size)
    }
}

//MARK: - Preference Key
struct ListGeometryPreferenceKey: PreferenceKey {
    
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

//struct TrackingPositionListCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrackingPositionListCellView()
//    }
//}
