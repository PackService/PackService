//
//  TrackingPositionListCellView.swift
//  PackService
//
//  Created by 박윤환 on 2023/01/16.
//

import SwiftUI

//MARK: - TrackingPositionListCellView
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
            circle
            
            // status + location
            leftColumn
            
            Spacer()
            
            // date + time
            rightColumn
        }
        
    }
}

extension TrackingPositionListCellView {
    
    //MARK: - Circle
    var circle: some View {
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
    }
    
    //MARK: - Left
    var leftColumn: some View {
        VStack(alignment: .leading) {
            Text(status)
                .font(FontManager.body2)
                .foregroundColor(ColorManager.defaultForeground)
            HStack {
                Text(position)
                    
                if let deliveryMan = deliveryMan {
                    if !deliveryMan.isEmpty {
                        Text("(\(deliveryMan))" )
                    }                    
                }
            }
            .font(FontManager.caption1)
            .foregroundColor(ColorManager.foreground1)            
        }
    }
    
    //MARK: - Right
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

//struct TrackingPositionListCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrackingPositionListCellView()
//    }
//}
