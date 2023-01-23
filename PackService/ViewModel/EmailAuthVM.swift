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
    
    init() {
        currentUser = Auth.auth().currentUser
    }
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
                return
            }
            
            self.logStatus = true // contentview에서 home으로 갈지 login으로 갈지 결정해줌. 로그인 누르면 homeview로 넘어가도록 함
        }
    }
    
    func addTrackNumber(trackNumber: String, trackCompany: String) { // 택배 create
        let db = Firestore.firestore()
        
        let packages = Packages(trackNumber: trackNumber, trackCompany: "대한통운")
        
        do {
            try db.collection("users").document(currentUser?.uid ?? "").updateData([
                "userTracksInfo": FieldValue.arrayUnion([packages.setTrackNumber])
            ])
        } catch let error {
            print("\(error)")
        }
    }
    
//    func readTrackNumber() {
//        let db = Firestore.firestore()
//        let docRef = db.collection("users").document(currentUser?.uid ?? "")
//        
//        docRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//                print("Document data: \(dataDescription)")
//            } else {
//                print("Document does not exist")
//            }
//        }
//    }
    
    
    func logout() {
        currentUser = nil
        try? Auth.auth().signOut()
    }
    
    func registerUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return } // 파이어베이스 유저 객체를 가져옴
            let trackInfo = TrackInfo(email: email, tracks: nil)
            
            if error == nil { //firebase db에 저장하는 방법
                self.currentUser = result?.user
                let db = Firestore.firestore()
                db.collection("users").document(user.uid).setData(trackInfo.setEmail)
            }
        }
    }
    
}
