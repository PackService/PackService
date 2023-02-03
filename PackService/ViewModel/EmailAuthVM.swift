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
import FirebaseFirestoreSwift

class EmailAuthVM: ObservableObject {
    @Published var trackInfo: TrackInfo?
    @State var userEmail: String = ""
    @Published var loginError: String = ""
    @Published var signUpError: String = ""
    @Published var pack = [Packages]()
    @AppStorage("log_status") var logStatus = false
    @Published var currentUser: Firebase.User?
    
    private var cancellables = Set<AnyCancellable>()
    let db = Firestore.firestore()
    init() {
        currentUser = Auth.auth().currentUser
        
        $trackInfo
            .sink { [weak self] info in
                guard let info = info else { return }
                
                self?.pack = info.userTracksInfo ?? []
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
            }
            self.loginError = ""
            self.readTrackNumber()
             // contentview에서 home으로 갈지 login으로 갈지 결정해줌. 로그인 누르면 homeview로 넘어가도록 함
        }
    }
    
    // 송장번호 추가
    func addTrackNumber(trackNumber: String, trackCompany: String) { // 택배 create
//        let db = Firestore.firestore()
        print("현재 아이디: \(currentUser?.uid ?? "")")
        let packages = Packages(trackCompany: trackCompany, trackNumber: trackNumber)
        
        do {
            try db.collection("users").document(currentUser?.uid ?? "").updateData([
                "userTracksInfo": FieldValue.arrayUnion([packages.setTrackNumber])
            ])
        } catch let error {
            print("\(error)")
        }
    }
    

    // 송장번호 하나 삭제
    func deleteTrackNumber(trackNumber: String) {
        let db = Firestore.firestore()
        let trackInfoData: [String: Any] = [
            "trackNumber" : trackNumber,
            "trackCompany" : "대한통운"
        ]
        
        DispatchQueue.main.async {
            db.collection("users").document(self.currentUser?.uid ?? "").updateData([
                "userTracksInfo" : FieldValue.arrayRemove([trackInfoData])
            ]) { error in
                if let error = error {
                    print("Unable to delete userTracksInfo: \(error.localizedDescription)")
                }  else {
                    print("Successfully deleted userTracksInfo")
                }
            }
        }
        
    }
    
    // 송장번호 읽어오기
    func readTrackNumber() {
        //        let db = Firestore.firestore()
//        let docRef = db.collection("users").document(currentUser?.uid ?? "")

//        docRef.getDocument { document, error in
//              if let error = error as NSError? {
//              }
//              else {
//                if let document = document {
//                  do {
//                    let userTracksInfoDoc = try document.data(as: TrackInfo.self)
////                      self.pacakge = userTracksInfoDoc["userTracksInfo"]
////                      self.pacakge = userTracksInfoDoc
////                      print("tqlfkdk")
//                      self.pack = userTracksInfoDoc.pack
//                      print(userTracksInfoDoc)
//                  }
//                  catch {
//                    print(error)
//                  }
//                }
//              }
//            }
        
            let docRef = Firestore.firestore()
              .collection("users")
              .document(currentUser?.uid ?? "")


            docRef.getDocument { document, error in
              if let error = error as NSError? {
//                self.errorMessage = "Error getting document: \(error.localizedDescription)"
              }
              else {
                if let document = document {
                  do {
                    let citiesDocument = try document.data(as: TrackInfo.self)
                      self.trackInfo = citiesDocument
                      self.logStatus = true
                  }
                  catch {
                    print(error)
                  }
                }
              }
            }
    }
//    func readTrackNumber() {
//        //        let db = Firestore.firestore()
//        let docRef = db.collection("users").document(currentUser?.uid ?? "")
//
//        docRef.getDocument { (document, error) in
//            guard error == nil else {
//                print("error", error ?? "")
//                return
//            }
//            if let document = document, document.exists {
//                let data = document.data()
//                if let data = data {
//                    self.freeboardTitle = data["email"] as? String ?? ""
//                    let sibal = data["userTracksInfo"] as? Packages ?? ""
////                    print(data["userTracksInfo"])
//                    print(sibal)
//                    print(data["email"])
//                }
//            }
//        }
//    }
  
    
    // 회원탈퇴
    func deleteUser() {
        let user = Auth.auth().currentUser
        user?.delete { error in
          if let error = error {
            // An error happened.
              print(error)
          } else {
            // Account deleted. 데이터베이스에서 해당 회원 정보들 다 삭제해줘야 함.
              self.db.collection("users").document(self.currentUser?.uid ?? "").delete() { err in
                  if let err = err {
                      print("Error removing document: \(err)")
                  } else {
                      print("Document successfully removed!")
                  }
              }
              print("현재 회원 삭제")
          }
        }
    }
    
    // 로그아웃
    func logout() {
        print("아직 로그인임\(currentUser)")
        currentUser = nil
        try? Auth.auth().signOut()
        print("로그아웃되었습니다\(currentUser)")
        logStatus = false
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
            let trackInfo = TrackInfo(email: email, userTracksInfo: nil)
            
            if error == nil { // firebase db에 저장하는 방법
                self.signUpError = "회원가입이 완료되었습니다"
                self.userEmail = email
                self.currentUser = result?.user
                print(self.userEmail)
//                let db = Firestore.firestore()
                self.db.collection("users").document(user.uid).setData(trackInfo.setEmail)
            }
        }
    }
}

func loginErrorhandler(error: String) -> String {
    if error == "There is no user record corresponding to this identifier. The user may have been deleted." {
        return "이메일이 존재하지 않습니다"
    } else {
        return ""
    }
}
