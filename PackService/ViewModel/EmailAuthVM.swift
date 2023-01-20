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
            
            guard let user = result?.user else { return } // 파이어베이스 유저 객체를 가져옴
                    
            if error == nil { //firebase db에 저장하는 방법
                self.currentUser = result?.user
                self.logStatus = true // contentview에서 home으로 갈지 login으로 갈지 결정해줌. 로그인 누르면 homeview로 넘어가도록 함
                let db = Firestore.firestore()
                db.collection("users").document(user.uid).setData(["email": email])
            }
        }
    }
    
//    func addTrackNumber(TrackNumber: String) {
//        let db = Firestore.firestore()
////        guard let user = currentUser?.uid else { return }
//        db.collection("users").document(currentUser?.uid ?? "").setData(["track_number": TrackNumber])
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
            
            guard let user = result?.user else { return }
            
            print(user.uid)
        }
    }
}
