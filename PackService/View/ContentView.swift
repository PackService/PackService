//
//  ContentView.swift
//  PackService
//
//  Created by 이범준 on 11/28/22.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("log_status") var logStatus = false
    var body: some View {
        ZStack {
            if logStatus {
                HomeView()
            } else {
                LoginUIView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
