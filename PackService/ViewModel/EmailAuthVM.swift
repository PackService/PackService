//
//  File.swift
//  PackService
//
//  Created by 이범준 on 11/30/22.
//

import SwiftUI
import Firebase
import Combine

class EmailAuthVM: ObservableObject { // 사용자 Create 완료
    @AppStorage("log_status") var logStatus = false
    @Published var currentUser: Firebase.User?
    let db = Firestore.firestore()
    init() {
        currentUser = Auth.auth().currentUser
    }
    
    // 로그인
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
                return
            }
            
            self.logStatus = true // contentview에서 home으로 갈지 login으로 갈지 결정해줌. 로그인 누르면 homeview로 넘어가도록 함
        }
    }
    
    // 송장번호 추가
    func addTrackNumber(trackNumber: String, trackCompany: String) { // 택배 create
//        let db = Firestore.firestore()
        
        let packages = Packages(trackNumber: trackNumber, trackCompany: "대한통운")
        
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
        let docRef = db.collection("users").document(currentUser?.uid ?? "")
        docRef.getDocument{ (document, error) in
            guard error == nil else {
                print("error", error ?? "")
                return
            }

            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    print("data", data)
//                    self.freeboardTitle = data["title"] as? String ?? ""
//                    self.freeboardNickName = data["nickname"] as? String ?? ""
                }
            }
        }
    }
    
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
        currentUser = nil
        try? Auth.auth().signOut()
    }
    
    // 회원가입
    func registerUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return } // 파이어베이스 유저 객체를 가져옴
            let trackInfo = TrackInfo(email: email, userTracksInfo: nil)
            
            if error == nil { // firebase db에 저장하는 방법
                self.currentUser = result?.user
//                let db = Firestore.firestore()
                self.db.collection("users").document(user.uid).setData(trackInfo.setEmail)
            }
        }
    }
    
}
