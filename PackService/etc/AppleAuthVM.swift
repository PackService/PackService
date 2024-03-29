//
//  AppleAuthVM.swift
//  PackService
//
//  Created by 이범준 on 11/29/22.
//

import Foundation
import SwiftUI
import CryptoKit
import AuthenticationServices
import Firebase

class AppleAuthVM: ObservableObject { // 사용자 Create 완료
    @Published var nonce = ""
    @AppStorage("log_status") var logStatus = false
    
    func authenticate(credential: ASAuthorizationAppleIDCredential) {
        // getting token
        guard let token = credential.identityToken else {
            print("error with firebase")
            return
        }
        guard let tokenString = String(data: token, encoding: .utf8) else {
            print("error with token")
            return
        }
        
        let firebaseCredential = OAuthProvider.credential(withProviderID: "apple.com", idToken: tokenString, rawNonce: nonce)
        
        Auth.auth().signIn(with: firebaseCredential) { (result, err) in
            if let error = err {
                print(error.localizedDescription)
                print("error")
                return
            }
            guard let user = result?.user else { return } // 파이어베이스 유저 객체를 가져옴
   
            if err == nil { // firebase db에 저장하는 방법
                let db = Firestore.firestore()
                db.collection("users").document(user.uid).setData(["email": user.email])
            }
            // usr succesfully logged into firebase
            print("login firebase")
            print(firebaseCredential)
            //
            withAnimation(.easeInOut) {
                self.logStatus = true
            }
        }
    }
}

//apple login with firebase
// Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
func sha256(_ input: String) -> String {
  let inputData = Data(input.utf8)
  let hashedData = SHA256.hash(data: inputData)
  let hashString = hashedData.compactMap {
    String(format: "%02x", $0)
  }.joined()

  return hashString
}

func randomNonceString(length: Int = 32) -> String {
  precondition(length > 0)
  let charset: [Character] =
    Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
  var result = ""
  var remainingLength = length

  while remainingLength > 0 {
    let randoms: [UInt8] = (0 ..< 16).map { _ in
      var random: UInt8 = 0
      let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
      if errorCode != errSecSuccess {
        fatalError(
          "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
        )
      }
      return random
    }

    randoms.forEach { random in
      if remainingLength == 0 {
        return
      }

      if random < charset.count {
        result.append(charset[Int(random)])
        remainingLength -= 1
      }
    }
  }

  return result
}

