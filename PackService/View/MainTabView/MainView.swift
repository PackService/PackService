//
//  MainView.swift
//  PackService
//
//  Created by 이범준 on 1/4/23.
//

import SwiftUI

// MARK: - MainView
struct MainView: View {
    @AppStorage("_isFirstLaunching") var isFirstLaunching: Bool = true
    var body: some View {
        NavigationView {
            TabView {
                MainTabView()
                    .tabItem {
                        Image(systemName: "house")
                            .environment(\.symbolVariants, .none)
                    }
//                PackListTabView()
                HomeView()
                    .tabItem {
                        Image(systemName: "shippingbox")
                            .environment(\.symbolVariants, .none)
                    }
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
        .onAppear(perform: { isFirstLaunching.toggle() })
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
