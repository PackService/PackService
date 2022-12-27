//
//  TrackingInfoModel.swift
//  PackService
//
//  Created by 박윤환 on 2022/12/26.
//

import Foundation

/*
 
 URL: https://info.sweettracker.co.kr/api/v1/trackingInfo?t_code=04&t_invoice=1111111111&t_key=eVPJb8troT0cn5eY15H6yw
 
 Samples:
         {
           "adUrl": "",
           "complete": true,
           "invoiceNo": "1111111111",
           "itemImage": "",
           "itemName": "",
           "level": 6,
           "receiverAddr": "",
           "receiverName": "",
           "recipient": "",
           "result": "Y",
           "senderName": "",
           "trackingDetails": [
             {
               "kind": "간선하차",
               "level": 3,
               "manName": "",
               "manPic": "",
               "telno": "051-719-5275",
               "telno2": "",
               "time": 1656725649000,
               "timeString": "2022-07-02 10:34:09",
               "where": "연제",
               "code": null,
               "remark": null
             },
           ],
           "orderNumber": null,
           "estimate": "08∼10시",
           "productInfo": null,
           "zipCode": null,
           "lastDetail": {
             "kind": "배달완료",
             "level": 6,
             "manName": "전봉준",
             "manPic": "",
             "telno": "031-923-9777",
             "telno2": "01063998832",
             "time": 1664414758000,
             "timeString": "2022-09-29 10:25:58",
             "where": "경기파주검산",
             "code": null,
             "remark": null
           },
           "lastStateDetail": {
             "kind": "배달완료",
             "level": 6,
             "manName": "전봉준",
             "manPic": "",
             "telno": "031-923-9777",
             "telno2": "01063998832",
             "time": 1664414758000,
             "timeString": "2022-09-29 10:25:58",
             "where": "경기파주검산",
             "code": null,
             "remark": null
           },
           "firstDetail": {
             "kind": "간선하차",
             "level": 3,
             "manName": "",
             "manPic": "",
             "telno": "051-719-5275",
             "telno2": "",
             "time": 1656725649000,
             "timeString": "2022-07-02 10:34:09",
             "where": "연제",
             "code": null,
             "remark": null
           },
           "completeYN": "Y"
         }
 */


// MARK: - TrackingInfo
struct TrackingInfoModel: Codable {
    let complete: Bool
    let level: Int
    let invoiceNo: String
    let isValidInvoice: String
    let itemImage, itemName: String
    let receiverAddr, receiverName, recipient: String
    let senderName: String
    let trackingDetails: [TrackingDetailsModel]
    let estimate: String?
    let productInfo: String?
    
    enum CodingKeys: String, CodingKey {
        case complete
        case level
        case invoiceNo
        case itemImage, itemName
        case receiverAddr, receiverName, recipient
        case senderName
        case trackingDetails
        case estimate
        case productInfo
        case isValidInvoice = "result"
    }
}

// MARK: - TrackingDetail
struct TrackingDetailsModel: Identifiable, Codable {
    let id = UUID().uuidString
    let kind: String
    let level: Int
    let manName, telno, telno2: String
    let timeString, detailWhere: String
    
    enum CodingKeys: String, CodingKey {
        case kind
        case level
        case manName, telno, telno2
        case timeString
        case detailWhere = "where"
    }
}
