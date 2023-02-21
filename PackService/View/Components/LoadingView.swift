//
//  LoadingView.swift
//  PackService
//
//  Created by 박윤환 on 2023/01/25.
//

import SwiftUI

//MARK: - LoadingView
struct LoadingView: View {
    
    @State private var loadingIcon: [String] = ["box.truck.fill", "shippingbox.fill", "house.fill"]
    @State private var loadingText: [String] = "Loading".map { String($0) }
    private let timer = Timer.publish(every: 0.6, on: .main, in: .common).autoconnect()
    private let timer1 = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    
    @State var index = 0
    @State var counter = 1
    
    var body: some View {
        ZStack {
            //Background
            background
            
            //Content
            VStack {
                Image(systemName: loadingIcon[index])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 55, height: 55)
                    .coordinateSpace(name: "icon")
                
                HStack(spacing: 0) {
                    ForEach(loadingText.indices, id: \.self) { index in
                        Text(loadingText[index].uppercased())
                            .font(FontManager.loading)
                            .offset(y: counter == index ? -3 : 0)
                    }
                }
                
            }
            .foregroundColor(ColorManager.primaryColor)
            
        }
        .onReceive(timer, perform: { _ in
            if index < loadingIcon.count - 1 {
                index += 1
            } else {
                index = 0
            }
        })
        .onReceive(timer1, perform: { _ in
            withAnimation(.spring()) {
                
                let last = loadingText.count - 1
           
                if counter == last {
                    counter = 0
                } else {
                    counter += 1
                }
            }
        })
    }
}

extension LoadingView {
    //MARK: - Background
    var background: some View {
        ColorManager.secondaryColor.opacity(0.2)
            .background(.ultraThinMaterial)
            .ignoresSafeArea()
    }
}

//struct LoadingView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoadingView()
//    }
//}
