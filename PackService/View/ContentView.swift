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
    @EnvironmentObject var service: LoginService
    var body: some View {
        ZStack {
            if logStatus {
                MainView(vm: MainViewModel(service: self.service))
            } else if !logStatus && isFirstLaunching {
                OnBoardingView(isFirstLaunching: $isFirstLaunching)
                if service.loginLoading == true {
                    LoadingView()
                }
            } else {
                LoginView()
                    .environmentObject(service)
                if service.loginLoading == true {
                    LoadingView()
                }
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
