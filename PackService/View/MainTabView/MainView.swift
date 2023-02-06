//
//  MainView.swift
//  PackService
//
//  Created by 이범준 on 1/4/23.
//

import SwiftUI

// MARK: - MainView
struct MainView: View {
//    @AppStorage("log_status") var logStatus = false
    
    @EnvironmentObject var emailService: EmailService
    var trackInfo: TrackInfo?
    @StateObject var vm = MainViewModel()
    
//    init(trackInfo: TrackInfo?) {
////        self.trackInfo = trackInfo
////        _vm = StateObject(wrappedValue: MainViewModel(emailService: self.emailService))
//    }
    
    var body: some View {
        NavigationView {
            TabView {
                MainTabView()
                    .tabItem {
                        Image(systemName: "house")
                            .environment(\.symbolVariants, .none)
                    }
                    .environmentObject(vm)
//                PackListTabView()
                PackListTabView()
                    .tabItem {
                        Image(systemName: "shippingbox")
                            .environment(\.symbolVariants, .none)
                    }
                    .environmentObject(vm)
                SystemTabView()
                    .tabItem {
                        Image(systemName: "gearshape")
                            .environment(\.symbolVariants, .none)
                    }
            }
            //        .padding(.leading, 20)
            .padding(.top, 20)
            .accentColor(ColorManager.primaryColor)
        }
        .onAppear {
            emailService.readTrackNumber()
//            print("mainView: \(emailService.trackInfo)")
//            self.vm.setup(emailService: self.emailService)
        }
//        .onAppear(perform: { isFirstLaunching.toggle() })
//        .onAppear(perform: {emailService.readTrackNumber()})
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
