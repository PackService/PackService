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
    @AppStorage("_isFirstLaunching") var isFirstLaunching: Bool = true
    @EnvironmentObject var service: LoginService
    @ObservedObject var vm: MainViewModel
    
    init(vm: MainViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        NavigationView {
            TabView {
                //메인 탭
                MainTabView()
                    .tabItem {
                        Image(systemName: "house")
                            .environment(\.symbolVariants, .none)
                    }
                    .environmentObject(vm)
                //리스트 탭
                ListTabView()
                    .tabItem {
                        Image(systemName: "shippingbox")
                            .environment(\.symbolVariants, .none)
                    }
                    .environmentObject(vm)
                //설정 탭
                SettingsTabView()
                    .tabItem {
                        Image(systemName: "gearshape")
                            .environment(\.symbolVariants, .none)
                    }
            }
            .padding(.top, 20)
            .accentColor(ColorManager.primaryColor)
            .onAppear {
                //Tabbar UI 설정
                let appearance = UITabBarAppearance()
                appearance.backgroundColor = UIColor(ColorManager.background)
                appearance.shadowColor = nil
                appearance.shadowImage = nil
             
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
        }
        .onAppear {
            service.currentUser = Auth.auth().currentUser //이걸 해줘야 현재 메인뷰 뜰때 현재 사용자 확인 가능, 애플 재접속시 오류 해결 부분
            service.readTrackNumber()
            print("메인뷰 onApear 현재 사용자 이메일은 : \(service.currentUser?.email)")
            isFirstLaunching = false
            service.loginLoading = false
        }
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
