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
    
    @UIApplicationDelegateAdaptor var appDelegate: AppDelegate
    @Environment(\.window) var window: UIWindow?
    @StateObject var emailAuthVM = EmailService()
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(emailAuthVM)
        }
    }
}
