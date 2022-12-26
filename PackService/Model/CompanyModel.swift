//
//  CompanyModel.swift
//  PackService
//
//  Created by 박윤환 on 2022/12/21.
//

import Foundation

/*
 
 URL: https://info.sweettracker.co.kr/api/v1/companylist?t_key=eVPJb8troT0cn5eY15H6yw
 
 Samples:
     "Company": [
         {
           "Code": "04",
           "International": "false",
           "Name": "CJ대한통운"
         },
         {
           "Code": "05",
           "International": "false",
           "Name": "한진택배"
         },
         {
           "Code": "08",
           "International": "false",
           "Name": "롯데택배"
         },
         {
           "Code": "01",
           "International": "false",
           "Name": "우체국택배"
         }, ...
 
 */

// MARK: - CompanyModel
struct CompanyModel: Codable {
    let company: [Company]
    
    enum CodingKeys: String, CodingKey {
        case company = "Company"
    }
}

// MARK: - Company
struct Company: Hashable, Identifiable, Codable {
    let id: String
    let international: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "Code"
        case international = "International"
        case name = "Name"
    }
}
