//
//  AgreementContentViewModel.swift
//  PackService
//
//  Created by 이범준 on 2/1/23.
//

import SwiftUI
import Firebase
import Combine

class AgreementContentViewModel: ObservableObject { // 사용자 Create 완료
    @Published var serviceAgreement: String = ""
    
    let db = Firestore.firestore()
    
    init() {
        self.readServiceAgreement()
    }
    
    func readServiceAgreement() {
        let docRef = Firestore.firestore()
            .collection("agreement")
            .document("personal")
        
        docRef.getDocument { (document, error) in
            guard error == nil else {
                print("error", error ?? "")
                return
            }
            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    self.serviceAgreement = data["content"] as? String ?? ""
                }
            }
        }
    }
}
