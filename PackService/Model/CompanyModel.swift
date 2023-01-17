//
//  CompanyModel.swift
//  PackService
//
//  Created by 박윤환 on 2022/12/21.
//

import Foundation
import SwiftUI

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
    var id: String
    let international: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "Code"
        case international = "International"
        case name = "Name"
    }
}

struct Logo {
    let image: Image
    let bgColor: Color
    let fgColor: Color
}

/*
cj 04, cupost 46, daesin 22, dhl 13, ems 12, fedex 21, gsi 41, gspostbox 24, hanjin 05, hapdong 32, ilyana 11, koreapost 01, kyeongdong 23, logen 06, lotte 08, lxpantos 37, nonghyup 53, tnt 25, ups 14, usps 26
*/

enum LogoType: String {
    
    case cj = "04"
    case cupost = "46"
    case daesin = "22"
    case dhl = "13"
    case ems = "12"
    case fedex = "21"
    case gsi = "41"
    case gspostbox = "24"
    case hanjin = "05"
    case hapdong = "32"
    case ilyana = "11"
    case koreapost = "01"
    case kyeongdong = "23"
    case logen = "06"
    case lotte = "08"
    case lxpantos = "37"
    case nonghyup = "53"
    case tnt = "25"
    case ups = "14"
    case usps = "26"
    case etc = "000"
    
    var logo: Logo {
        switch self {
        case .cj, .cupost, .daesin, .dhl, .ems, .fedex, .gsi, .gspostbox, .hanjin, .hapdong, .ilyana, .koreapost, .kyeongdong, .logen, .lotte, .lxpantos, .nonghyup, .tnt, .ups, .usps:
            return Logo(image: Image("logo_\(self)"), bgColor: Color("bgcolor_\(self)"), fgColor: Color("fgcolor_\(self)"))
        default:
            return Logo(image: Image(systemName: "box.truck.fill"), bgColor: ColorManager.background2, fgColor: ColorManager.black)
        }
    }
}

