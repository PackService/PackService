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
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            TrackingDetailLoadingView(companyId: .constant("08"), invoiceNumber: .constant("248569159322"))
        }
    }
}
