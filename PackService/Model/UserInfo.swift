//
//  UserData.swift
//  PackService
//
//  Created by 이범준 on 12/21/22.
//

import Foundation
import FirebaseFirestoreSwift

//MARK: - UserInfo
struct UserInfo: Codable/*, Identifiable*/ {
//    @DocumentID var id: String?
    let email: String
    var history: [String]
    var trackInfos: [TrackInfos]?
    
    enum CodingKeys: String, CodingKey {
        case email
        case history
        case trackInfos
    }
    
    var setEmail: [String: Any] {
        return [
            "email": self.email
        ]
    }
    
    var setHistory: [String: Any] {
        return [
            "history": self.history
        ]
    }
    
    var setTrackInfos: [String: Any] {
        return [
            "trackInfos": self.trackInfos ?? []
        ]
    }   
   
}

//MARK: - TrackInfos
struct TrackInfos: Codable, Hashable {
    var timeStamp: Date
    var company: String
    var invoice: String
    
    var setInvoice: [String: Any] {
        return [
            "timeStamp": self.timeStamp,
            "company": self.company,
            "invoice": self.invoice
        ]
    }
    
    enum CodingKeys: String, CodingKey {
        case timeStamp 
        case company
        case invoice
    }
}
