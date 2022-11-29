//
//  PackServiceApp.swift
//  PackService
//
//  Created by 이범준 on 11/28/22.
//

import SwiftUI
import Firebase

@main
struct PackServiceApp: App {
    
    @UIApplicationDelegateAdaptor(Appdelegate2.self) var delegate
    @UIApplicationDelegateAdaptor var appDelegate: AppDelegate
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class Appdelegate2: NSObject,UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

