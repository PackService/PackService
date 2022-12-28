//
//  AnimatedCircle.swift
//  PackService
//
//  Created by 박윤환 on 2022/12/28.
//

import SwiftUI

struct AnimatedCircle: View {
    
    @State var isAnimated: Bool = false
    
    var body: some View {
        VStack {
            Button {
                isAnimated.toggle()
            } label: {
                Text("PRESS")
            }
            
//            Circle()
//                .fill(Color.blue)
//                .frame(width: 30, height: 30)
//                .background(
//                    Circle()
//                        .stroke(lineWidth: 10)
//                        .fill(Color.blue.opacity(0.4))
//                        .frame(
//                            width: isAnimated ? 50 : 30,
//                            height: isAnimated ? 50 : 30
//                        )
//                        .animation(
//                            Animation
//                                .default
//                                .repeatForever(autoreverses: true), value: isAnimated)
//
//                )
            
            Circle()
                .fill(Color.blue)
                .frame(
                    width: isAnimated ? 30 : 40,
                    height: isAnimated ? 30 : 40
                )
                .animation(
                    Animation
                        .default
                        .speed(0.5)
                        .repeatForever(autoreverses: true),
                    value: isAnimated
                )
        }

        
        
    }
}

struct AnimatedCircle_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedCircle()
    }
}
