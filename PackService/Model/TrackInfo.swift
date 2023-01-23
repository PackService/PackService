//
//  UserData.swift
//  PackService
//
//  Created by 이범준 on 12/21/22.
//

import Foundation

// 서버에서 넘어올 사용자 데이터
public struct TrackInfo: Codable {
    
    let email: String?
    let userTracksInfo: [Packages]?
    
    var setEmail: [String:Any] {
        return [
            "email": self.email
        ]
    }
}

public struct Packages: Codable {
    let trackNumber: String?
    let trackCompany: String?
    
    var setTrackNumber: [String:Any] {
        return [
            "trackNumber": self.trackNumber,
            "trackCompany": self.trackCompany
        ]
    }
    
    var setPackages: Any {
        return self
    }
}
