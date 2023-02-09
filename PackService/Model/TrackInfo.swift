//
//  UserData.swift
//  PackService
//
//  Created by 이범준 on 12/21/22.
//

import Foundation
import FirebaseFirestoreSwift


//struct City: Codable, Hashable {
//  var name: String
//  var latitude: String
//  var longitude: String
//}
// 서버에서 넘어올 사용자 데이터
struct TrackInfo: Codable, Identifiable {
    @DocumentID var id: String?
    let email: String
    var userTracksInfo: [Packages]?
//    @ServerTimestamp var createdTime: Timestamp? // (3)
    var setEmail: [String:Any] {
        return [
            "email": self.email
        ]
    }
    enum CodingKeys: String, CodingKey {
        case email = "email"
        case userTracksInfo = "userTracksInfo"
    }
}

struct Packages: Codable, Hashable {
    var timeStamp: Date
    var trackCompany: String
    var trackNumber: String
//    var count: String
    
    var setTrackNumber: [String: Any] {
        return [
            "timeStamp": self.timeStamp,
            "trackCompany": self.trackCompany,
            "trackNumber": self.trackNumber,
//            "count": self.count
        ]
    }
    
    enum CodingKeys: String, CodingKey {
        case timeStamp
        case trackCompany = "trackCompany"
        case trackNumber = "trackNumber"
    }
//    var setPackages: Any {
//        return self
//    }
}
