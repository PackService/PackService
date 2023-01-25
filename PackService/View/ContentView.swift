//
//  ContentView.swift
//  PackService
//
//  Created by 이범준 on 11/28/22.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("log_status") var logStatus = false
    @AppStorage("_isFirstLaunching") var isFirstLaunching: Bool = true

    var body: some View {
//        OnBoardingView()
//        // 앱 최초 구동 시 전체화면으로 OnboardingTabView 띄우기
//            .fullScreenCover(isPresented: $isFirstLaunching) {
//                OnBoardingView(isFirstLaunching: $isFirstLaunching)
//            }
        ZStack {
            if logStatus {
                MainView()
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
