//
//  SwiftUIView.swift
//  PackService
//
//  Created by 이범준 on 12/21/22.
//

import SwiftUI

struct SignUpView: View {
    @Binding var firstNaviLinkActive: Bool
    var body: some View {
        VStack{
            Text("This is Last Page.")
            Button(action: {
                firstNaviLinkActive = false
            }, label: {
                Text("Main으로 돌아가기")
                    .foregroundColor(Color.white)
                    .frame(width: 100, height: 60, alignment: .center)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .fill(Color.purple))
            })
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(firstNaviLinkActive: .constant(true))
    }
}
