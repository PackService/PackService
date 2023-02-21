//
//  AppleAuthViewModel.swift
//  PackService
//
//  Created by 박윤환 on 2023/01/26.
//

import Foundation
import SwiftUI
import CryptoKit
import Firebase
import FirebaseAuth
import AuthenticationServices

//class AppleAuthViewModel: NSObject, ObservableObject {
//    var currentNonce: String?
//    let window: UIWindow?
//    @AppStorage("log_status") var logStatus = false
//
//    init(window: UIWindow?) {
//        self.window = window
//    }
//
//    func startAppleLogin() {
//        let nonce = randomNonceString()
//        currentNonce = nonce
//        let appleIDProvider = ASAuthorizationAppleIDProvider()
//        let request = appleIDProvider.createRequest()
//        request.requestedScopes = [.fullName, .email]
//        request.nonce = sha256(nonce)
//
//        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
//        authorizationController.delegate = self
//        authorizationController.presentationContextProvider = self
//        authorizationController.performRequests()
//    }
//
//    func logout() {
////        try? Auth.auth().signOut()
//        self.logStatus = false
//
//    }
//
//    private func sha256(_ input: String) -> String {
//        let inputData = Data(input.utf8)
//        let hashedData = SHA256.hash(data: inputData)
//        let hashString = hashedData.compactMap {
//            return String(format: "%02x", $0)
//        }.joined()
//
//        return hashString
//    }
//
//    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
//    private func randomNonceString(length: Int = 32) -> String {
//        precondition(length > 0)
//        let charset: Array<Character> =
//          Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
//        var result = ""
//        var remainingLength = length
//
//        while remainingLength > 0 {
//            let randoms: [UInt8] = (0 ..< 16).map { _ in
//                var random: UInt8 = 0
//                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
//                if errorCode != errSecSuccess {
//                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
//
//                }
//                return random
//
//            }
//
//            randoms.forEach { random in
//                if remainingLength == 0 {
//                    return
//
//                }
//
//                if random < charset.count {
//                    result.append(charset[Int(random)])
//                    remainingLength -= 1
//                }
//            }
//        }
//        return result
//    }
//}
//
//extension AppleAuthViewModel: ASAuthorizationControllerDelegate {
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
//          guard let nonce = currentNonce else {
//            fatalError("Invalid state: A login callback was received, but no login request was sent.")
//          }
//          guard let appleIDToken = appleIDCredential.identityToken else {
//            print("Unable to fetch identity token")
//            return
//          }
//          guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
//            print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
//            return
//          }
//
//          // Initialize a Firebase credential.
//          let credential = OAuthProvider.credential(withProviderID: "apple.com",
//              idToken: idTokenString,
//              rawNonce: nonce)
//
//          //Firebase 작업
//          Auth.auth().signIn(with: credential) { (authResult, error) in
//              if let error = error {
//              // Error. If error.code == .MissingOrInvalidNonce, make sure
//              // you're sending the SHA256-hashed nonce as a hex string with
//              // your request to Apple.
//                  print(error.localizedDescription)
//                  return
//              } else {
//                  guard let user = authResult?.user else { return }
//                  print(idTokenString)
//                  let db = Firestore.firestore()
//                  db.collection("users").document(user.uid).setData(["email": user.email])
//
//                  self.logStatus = true
//              }
//            // User is signed in to Firebase with Apple.
//            // ...
//          }
//        }
//      }
//}
//
//extension AppleAuthViewModel: ASAuthorizationControllerPresentationContextProviding {
//    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
//        window!
//    }
//}
//
//struct WindowKey: EnvironmentKey {
//    struct Value {
//        weak var value: UIWindow?
//    }
//
//    static let defaultValue: Value = .init(value: nil)
//}
//
//extension EnvironmentValues {
//    var window: UIWindow? {
//        get {
//            return self[WindowKey.self].value
//        }
//        set {
//            self[WindowKey.self] = .init(value: newValue)
//        }
//    }
//}
