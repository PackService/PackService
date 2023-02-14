//
//  MainView.swift
//  PackService
//
//  Created by 이범준 on 1/4/23.
//

import SwiftUI
import FirebaseAuth

// MARK: - MainView
struct MainView: View {
//    @AppStorage("log_status") var logStatus = false
    @AppStorage("_isFirstLaunching") var isFirstLaunching: Bool = true
    @EnvironmentObject var emailService: EmailService
    var trackInfo: TrackInfo?
    @ObservedObject var vm: MainViewModel
    
    init(vm: MainViewModel) {
        self.vm = vm
//        self.trackInfo = trackInfo
//        _vm = StateObject(wrappedValue: MainViewModel(emailService: self.emailService))
    }
    
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
            .padding(.top, 20)
            .accentColor(ColorManager.primaryColor)
            
//            .background(ColorManager.primaryColor)
            .onAppear {
                let appearance = UITabBarAppearance()
                appearance.backgroundColor = UIColor(ColorManager.background)
                appearance.shadowColor = nil
                appearance.shadowImage = nil
             
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
        }
        .onAppear {
            emailService.currentUser = Auth.auth().currentUser //이걸 해줘야 현재 메인뷰 뜰때 현재 사용자 확인 가능, 애플 재접속시 오류 해결 부분
            emailService.readTrackNumber()
            print("메인뷰 onApear 현재 사용자 이메일은 : \(emailService.currentUser?.email)")
            isFirstLaunching = false
            emailService.loginLoading = false
        }
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
