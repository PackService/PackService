//
//  ExampleView.swift
//  PackService
//
//  Created by 박윤환 on 2022/12/29.
//

import SwiftUI
import UIKit

struct ExampleParentView: View {
    var body: some View {
        NavigationView {
            VStack {
                
                Spacer()
                ExampleView()
            }
            .navigationTitle("This is Parent View")
        }
    }
}

struct ExampleView: View {
    
    @State var showList = false
    
    var body: some View {
        VStack {
            Button {
                showList.toggle()
            } label: {
                Text("리스트 보기")
            }

            Spacer()
            
//            VStack {
                if showList {
                    List(1..<10) { index in
                        TrackingPositionListCellView(status: "집화처리", position: "군포직영", deliveryMan: "홍길동", time: "07:48", date: "2022.11.22", isCurrent: true)
                            .listRowSeparator(.hidden)
                    }
                    .listStyle(InsetListStyle())
                }
//            }
        }
        
    }
}

struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleParentView()
    }
}
