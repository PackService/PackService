//
//  UserData.swift
//  PackService
//
//  Created by 이범준 on 12/21/22.
//

import Foundation
import FirebaseFirestoreSwift

// 서버에서 넘어올 사용자 데이터
struct TrackInfo: Codable, Identifiable {
    @DocumentID var id: String?
    let email: String
    var history: [String]
    var userTracksInfo: [Packages]?
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
        case history
        case userTracksInfo = "userTracksInfo"
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
    
    var setUserTracksInfo: [String: Any] {
        return [
            "userTracksInfo": self.userTracksInfo
        ]
    }   
   
}

struct Packages: Codable, Hashable {
    var timeStamp: Date
    var trackCompany: String
    var trackNumber: String
    
    var setTrackNumber: [String: Any] {
        return [
            "timeStamp": self.timeStamp,
            "trackCompany": self.trackCompany,
            "trackNumber": self.trackNumber
        ]
    }
    
    enum CodingKeys: String, CodingKey {
        case timeStamp 
        case trackCompany = "trackCompany"
        case trackNumber = "trackNumber"
    }
}


