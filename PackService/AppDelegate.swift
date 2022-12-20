//
//  AppDelegate.swift
//  PackService
//
//  Created by 이범준 on 11/28/22.
//

import Foundation
import UIKit
import KakaoSDKCommon
import KakaoSDKAuth

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] ?? ""
        KakaoSDK.initSDK(appKey: kakaoAppKey as! String)
        print("kakaoAppKey: \(kakaoAppKey)")
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if (AuthApi.isKakaoTalkLoginUrl(url)) {
            return AuthController.handleOpenUrl(url: url)
        }
        
        return false
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        let sceneConfiguratioin = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfiguratioin.delegateClass = SceneDelegate.self
        return sceneConfiguratioin
    }
}
