//
//  File.swift
//  PackService
//
//  Created by 이범준 on 11/30/22.
//

import SwiftUI
import Foundation
import Firebase
import Combine
import KakaoSDKAuth
import KakaoSDKUser
import FirebaseFirestoreSwift
import CryptoKit
import FirebaseAuth
import AuthenticationServices
import FirebaseAnalytics

class LoginService: ObservableObject {
    @Published var userInfo: UserInfo?
    @Published var loginError: String = ""
    @Published var signUpError: String = ""
    @Published var repeatTrackNumberError: String = ""
    @Published var trackInfos = [TrackInfos]()
    @Published var currentUser: Firebase.User?
    @Published var loginLoading = false
    @AppStorage("log_status") var logStatus = false
    
    let db = Firestore.firestore()
    var currentNonce: String?
    var window: UIWindow?
    var apple: AppleAuthViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        currentUser = Auth.auth().currentUser
        print("emailService 현재 사용자: \(currentUser?.email)")
        $userInfo
            .sink { [weak self] info in
                guard let info = info else { return }
                
                self?.trackInfos = info.trackInfos ?? []
            }
            .store(in: &cancellables)
    }
    
    // 로그인
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email + "2", password: password) { result, error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
                self.loginError = loginErrorhandler(error: error.localizedDescription)
                return
            } else {
                self.loginLoading = true
                self.currentUser = result?.user
                self.loginError = ""
                self.readTrackNumber()
            }
        }
    }
    
    // 송장번호 추가
    func addTrackNumber(company: String, invoice: String) { // 택배 create
        let packages = TrackInfos(timeStamp: Date(), company: company, invoice: invoice)
        
        do {
            let db = Firestore.firestore()
            try db.collection("users").document(currentUser!.uid).updateData([
                "trackInfos": FieldValue.arrayUnion([packages.setInvoice])
            ])
        } catch let error {
            print("\(error)")
        }
    }
    
    func findRepeatTrackNumber(company: String, invoice: String) {
        guard let value = userInfo?.trackInfos else {
            return
        }
        if value.first(where: { $0.company == company && $0.invoice == invoice }) != nil { // 추가 불가능
            repeatTrackNumberError = "동일한 송장번호가 이미 존재합니다"
        } else { // 추가 가능
            repeatTrackNumberError = ""
        }
        print("repeatTrackNumberError : \(repeatTrackNumberError)")
    }

    func updateHistory(company: String, invoice: String) {
        let arr = [company, invoice]
        do {
            let db = Firestore.firestore()
            try db.collection("users").document(currentUser!.uid).updateData([
                "history": arr
            ])
        } catch let error {
            print("\(error)")
        }
    }
    
    // 송장번호 하나 삭제
    func deleteTrackNumber(company: String, invoice: String) {
        db.runTransaction{ (trans, errorPointer) -> Any? in
            let doc: DocumentSnapshot
            let docRef = self.db.collection("users").document(self.currentUser!.uid)

            // get the document
            do {
                try doc = trans.getDocument(docRef)
            } catch let error as NSError {
                errorPointer?.pointee = error
                return nil
            }

            // get the items from the document
            if let items = doc.get("trackInfos") as? [[String: Any]] {

                // find the element to delete
                if let toDelete = items.first(where: { (element) -> Bool in

                    // the predicate for finding the element
                    if let number = element["invoice"] as? String,
                       number == invoice {
                        return true
                    } else {
                        return false
                    }
                }) {
                    // element found, remove it
                    docRef.updateData([
                        "trackInfos": FieldValue.arrayRemove([toDelete])
                    ])
                    
                    self.readTrackNumber()
                }
            } else {
                // array itself not found
                print("items not found")
            }
            return nil // you can return things out of transactions but not needed here so return nil
        } completion: { (_, error) in
            if let error = error {
                print(error)
            } else {
                print("transaction done")
            }
        }
    }
    
    func deleteAllData() {
        do {
            let db = Firestore.firestore()
            try db.collection("users").document(currentUser!.uid).updateData([
                "history": [],
                "trackInfos": []
            ])
        } catch let error {
            print("\(error)")
        }
    }
    
    // 송장번호 읽어오기
    func readTrackNumber() {
        if currentUser?.uid != nil {
            let docRef = Firestore.firestore()
                .collection("users")
                .document(currentUser!.uid)
            
            docRef.getDocument { document, error in
                if let error = error as NSError? {
                    print(error.localizedDescription)
                }
                else {
                    if let document = document {
                        do {
                            let userDocument = try document.data(as: UserInfo.self)
                            self.userInfo = userDocument
                            self.logStatus = true
                        }
                        catch {
                            print(error)
                        }
                    }
                }
            }
        } else {
            logStatus = false
        }
    }
    
    // 회원탈퇴
    func deleteUser() {
        let user = Auth.auth().currentUser
        self.db.collection("users").document(self.currentUser!.uid).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        user?.delete { error in
            if let error = error {
                // An error happened.
                print("delete 에러 발생")
                print(error)
            } else {
                // Account deleted. 데이터베이스에서 해당 회원 정보들 다 삭제해줘야 함.
                print("현재 회원 삭제")
                self.currentUser = nil
                self.logStatus = false
            }
        }
    }
    
    // 로그아웃
    func logout() {
        print("아직 로그인임\(currentUser)")
        try? Auth.auth().signOut()
        currentUser = nil
        logStatus = false
        print("로그아웃되었습니다\(currentUser)")
    }
    
    // 회원가입
    func registerUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email + "2", password: password) { result, error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
                self.signUpError = "이미 해당 이메일이 존재합니다"
                return
            }
            
            guard let user = result?.user else { return } // 파이어베이스 유저 객체를 가져옴
            let trackInfo = UserInfo(email: email, history: [], trackInfos: nil)
            
            if error == nil { // firebase db에 저장하는 방법
//                self.loginLoading = true // 여기서 한번 alert창 띄워보기
                self.signUpError = "회원가입이 완료되었습니다"
//                self.currentUser = result?.user
                
                self.db.collection("users").document(user.uid).setData(["email": user.email, "history": []])
//                db.collection("users").document(user.uid).setData(trackInfo.setHistory)
            }
        }
    }
    
    //MARK: -kakaoLogin
    
    @MainActor
    func kakaoLogout() {
        Task {
            if await handleKakaoLogout() {
                try? Auth.auth().signOut()
                currentUser = nil
            }
        }
    }
    
    func handleKakaoLogout() async -> Bool {
        await withCheckedContinuation{ continuation in
            UserApi.shared.logout {(error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("logout() success.")
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
    func handleLoginWithKakaoTalkApp() async -> Bool {
        // 카카오 앱을 통해 로그인
        await withCheckedContinuation{ continuation in
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    if let token = oauthToken {
                        self.loginInFirebase()
                        continuation.resume(returning: true)
                    }
                }
            }
        }
    }
    
    func handleLoginWithKakaoAccount() async -> Bool {
        await withCheckedContinuation { continuation in
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("DEBUG: 카카오톡 로그인 Success")
                    if let token = oauthToken {
                        print("DEBUG: 카카오톡 토큰 \(token)")
                        self.loginInFirebase()
                        continuation.resume(returning: true)
                    }
                }
            }
        }
    }
    
    @MainActor
    func handleKakaoLogin() {
        Task {
            // 카카오톡 설치 여부 확인 - 설치 되어있을 때
            print("handleKakaoLogin1")
            if (UserApi.isKakaoTalkLoginAvailable()) {
                //카카오 앱을 통해 로그인
                logStatus = await handleLoginWithKakaoTalkApp()
            } else { //카카오톡 설치 안되어있을 때
                //카카오 웹뷰로 로그인
                logStatus = await handleLoginWithKakaoAccount()
            }
        }
        print("handleKakaoLogin2")
    }
    
    func loginInFirebase() {
        print("handleKakaoLogin3")
        UserApi.shared.me() { user, error in
            if let error = error {
                print("DEBUG: 카카오톡 사용자 정보가져오기 에러 \(error.localizedDescription)")
            } else {
                print("DEBUG: 카카오톡 사용자 정보가져오기 success.")
                self.loginLoading = true
                // 파이어베이스 유저 생성 (이메일로 회원가입)
                Auth.auth().createUser(withEmail: ((user?.kakaoAccount?.email ?? "") + "1"),
                                       password: "\(String(describing: user?.id))") { result, error in
                    if let error = error {
                        print("DEBUG: 파이어베이스 사용자 생성 실패 \(error.localizedDescription)")
                        Auth.auth().signIn(withEmail: ((user?.kakaoAccount?.email ?? "") + "1"),
                                           password: "\(String(describing: user?.id))") { result, error in
                            if let error = error {
                                print("Error : \(error.localizedDescription)")
                                return
                            }
                            self.currentUser = result?.user
                            self.readTrackNumber()
                        }
                        print("로그인되었음")
                    } else {
                        print("DEBUG: 파이어베이스 사용자 생성")
                        self.currentUser = result?.user // 이거 안하면 uid 달라짐
                        guard let user = self.currentUser else { return } // 파이어베이스 유저 객체를 가져옴
                        self.db.collection("users").document(user.uid).setData(["email": user.email, "history": []])
                    }
                }
            }
        }
        print("handleKakaoLogin4")
    }

}

func loginErrorhandler(error: String) -> String {
    if error == "There is no user record corresponding to this identifier. The user may have been deleted." {
        return "이메일이 존재하지 않습니다"
    } else if error == "The password is invalid or the user does not have a password." {
        return "비밀번호를 확인해주세요"
    } else {
        return ""
    }
}

class AppleAuthViewModel: NSObject, ObservableObject {
    @Published var currentUser: Firebase.User?
    @State private var emailService: LoginService?
    var currentNonce: String?
    let window: UIWindow?
    @AppStorage("log_status") var logStatus = false
    
    init(window: UIWindow?) {
        self.window = window
    }

    func startAppleLogin() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

    func logout() {
        try? Auth.auth().signOut()
        self.logStatus = false
    }

    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()

        return hashString
    }

    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
          Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length

        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")

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
}

extension AppleAuthViewModel: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
          guard let nonce = currentNonce else {
            fatalError("Invalid state: A login callback was received, but no login request was sent.")
          }
          guard let appleIDToken = appleIDCredential.identityToken else {
            print("Unable to fetch identity token")
            return
          }
          guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
            print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
            return
          }

          // Initialize a Firebase credential.
          let credential = OAuthProvider.credential(withProviderID: "apple.com",
              idToken: idTokenString,
              rawNonce: nonce)

          Auth.auth().signIn(with: credential) { (authResult, error) in
              if let error = error {
                  print(error.localizedDescription)
                  print("애플 로그인 에러 발생!")
                  return
              } else {
                  self.currentUser = authResult?.user
                  guard let user = authResult?.user else { return }
                  self.emailService?.loginLoading = true
                  print("현재 애플 로그인 유저:\(self.currentUser?.email)")
                  
                  let db = Firestore.firestore()
                  
                  db.collection("users").document(user.uid).getDocument { document, error in
                      if let error = error as NSError? {
                          print("get document Error 발생")
                      }
                      else {
                          if let document = document, document.exists {
                              print("이미 존재해서 안만듬")
                          } else {
                              db.collection("users").document(user.uid).setData(["email": user.email, "history": []])
                              print("없으니까 만들게")
                          }
                      }
                  }
                  self.logStatus = true
              }
          }
        }
      }
    
    
}

extension AppleAuthViewModel: ASAuthorizationControllerPresentationContextProviding {
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        window!
    }
}

struct WindowKey: EnvironmentKey {
    struct Value {
        weak var value: UIWindow?
    }

    static let defaultValue: Value = .init(value: nil)
}

extension EnvironmentValues {
    var window: UIWindow? {
        get {
            return self[WindowKey.self].value
        }
        set {
            self[WindowKey.self] = .init(value: newValue)
        }
    }
}
