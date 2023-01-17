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
    case handex = "20"
    case hanuisalang = "16"
    case chunil = "17"
    case geonyeong = "18"
    case goodtoluck = "40"
    case anytrack = "43"
    case slx = "44"
    case uripost = "45"
    case urihanbang = "47"
    case homepick = "54"
    case ik = "71"
    case seonghun = "72"
    case yongma = "74"
    case wondeoseu = "75"
    case logisbellypost = "79"
    case curlly = "82"
    case pullathome = "85"
    case samsung = "86"
    case querun = "88"
    case dubalhero = "89"
    case winia = "90"
    case ginigo = "92"
    case onlpickup = "94"
    case logisbelly = "96"
    case hansamservice = "101"
    case ndexkorea = "103"
    case dodoflex = "104"
    case lgjeonja = "107"
    case buleung = "110"
    case angelhome = "112"
    case thunderhero = "113"
    case teampressy = "116"
    case lottechillsung = "118"
    case pingpong = "119"
    case ballex = "120"
    case ntlpeace = "123"
    case gts = "125"
    case logispot = "127"
    case homepicktoday = "129"
    case ufo = "130"
    case dilirabbit = "131"
    case gop = "132"
    case hkholdings = "134"
    case htns = "135"
    case kjt = "136"
    case deobao = "137"
    case lastmile = "138"
    case oneulrush = "139"
    case tangoandgo = "142"
    case today = "143"
    case hyeondaiglobal = "145"
    case argo = "148"
    case giant = "151"
    case gsmnton = "28"
    case kglnetworks = "30"
    case dhlglobalmail = "33"
    case iparcel = "34"
    case ecms = "38"
    case cjglobal = "42"
    case aci = "48"
    case ace = "49"
    case gps = "50"
    case seongwonglobal = "51"
    case europarcel = "55"
    case cway = "57"
    case yjsglobal = "60"
    case eunha = "63"
    case yjs = "65"
    case giantnetwork = "66"
    case didi = "67"
    case daelim = "69"
    case lotos = "70"
    case cr = "73"
    case lineexpress = "77"
    case jeniel = "81"
    case smart = "84"
    case etomars = "87"
    case hivecity = "91"
    case panstar = "93"
    case qexpress = "95"
    case acitykorea = "97"
    case lotteglobal = "99"
    case naeun = "100"
    case postgoodday = "102"
    case bridge = "105"
    case hubnet = "106"
    case mexglobal = "108"
    case patech = "109"
    case sbgls = "111"
    case canada = "114"
    case yunda = "117"
    case bababa = "121"
    case baima = "122"
    case ltl = "124"
    case olta = "126"
    case panworld = "128"
    case jiggumun = "140"
    case interlogis = "141"
    case cubleflow = "144"
    case kse = "146"
    case stheshipping = "147"
    case goldsnaps = "149"
    case mtinter = "152"
    
    func simpleDescription() -> String {
        switch self {
        case .cj:
            return "CJ대한통운"
        case .cupost:
            return "CU편의점택배"
        case .daesin:
            return "대신택배"
        case .dhl:
            return "DHL"
        case .ems:
            return "EMS"
        case .fedex:
            return "FedEx"
        case .gsi:
            return "GSI Express"
        case .gspostbox:
            return ""
        case .hanjin:
            return ""
        case .hapdong:
            return ""
        case .ilyana:
            return ""
        case .koreapost:
            return ""
        case .kyeongdong:
            return ""
        case .logen:
            return ""
        case .lotte:
            return ""
        case .lxpantos:
            return ""
        case .nonghyup:
            return ""
        case .tnt:
            return ""
        case .ups:
            return ""
        case .usps:
            return ""
        case .handex:
            return ""
        case .hanuisalang:
            return ""
        case .chunil:
            return ""
        case .geonyeong:
            return ""
        case .goodtoluck:
            return ""
        case .anytrack:
            return ""
        case .slx:
            return ""
        case .uripost:
            return ""
        case .urihanbang:
            return ""
        case .homepick:
            return ""
        case .ik:
            return ""
        case .seonghun:
            return ""
        case .yongma:
            return ""
        case .wondeoseu:
            return ""
        case .logisbellypost:
            return ""
        case .curlly:
            return ""
        case .pullathome:
            return ""
        case .samsung:
            return ""
        case .querun:
            return ""
        case .dubalhero:
            return ""
        case .winia:
            return ""
        case .ginigo:
            return ""
        case .onlpickup:
            return ""
        case .logisbelly:
            return ""
        case .hansamservice:
            return ""
        case .ndexkorea:
            return ""
        case .dodoflex:
            return ""
        case .lgjeonja:
            return ""
        case .buleung:
            return ""
        case .angelhome:
            return ""
        case .thunderhero:
            return ""
        case .teampressy:
            return ""
        case .lottechillsung:
            return ""
        case .pingpong:
            return ""
        case .ballex:
            return ""
        case .ntlpeace:
            return ""
        case .gts:
            return ""
        case .logispot:
            return ""
        case .homepicktoday:
            return ""
        case .ufo:
            return ""
        case .dilirabbit:
            return ""
        case .gop:
            return ""
        case .hkholdings:
            return ""
        case .htns:
            return ""
        case .kjt:
            return ""
        case .deobao:
            return ""
        case .lastmile:
            return ""
        case .oneulrush:
            return ""
        case .tangoandgo:
            return ""
        case .today:
            return ""
        case .hyeondaiglobal:
            return ""
        case .argo:
            return ""
        case .giant:
            return ""
        case .gsmnton:
            return ""
        case .kglnetworks:
            return ""
        case .dhlglobalmail:
            return ""
        case .iparcel:
            return ""
        case .ecms:
            return ""
        case .cjglobal:
            return ""
        case .aci:
            return ""
        case .ace:
            return ""
        case .gps:
            return ""
        case .seongwonglobal:
            return ""
        case .europarcel:
            return ""
        case .cway:
            return ""
        case .yjsglobal:
            return ""
        case .eunha:
            return ""
        case .yjs:
            return ""
        case .giantnetwork:
            return ""
        case .didi:
            return ""
        case .daelim:
            return ""
        case .lotos:
            return ""
        case .cr:
            return ""
        case .lineexpress:
            return ""
        case .jeniel:
            return ""
        case .smart:
            return ""
        case .etomars:
            return ""
        case .hivecity:
            return ""
        case .panstar:
            return ""
        case .qexpress:
            return ""
        case .acitykorea:
            return ""
        case .lotteglobal:
            return ""
        case .naeun:
            return ""
        case .postgoodday:
            return ""
        case .bridge:
            return ""
        case .hubnet:
            return ""
        case .mexglobal:
            return ""
        case .patech:
            return ""
        case .sbgls:
            return ""
        case .canada:
            return ""
        case .yunda:
            return ""
        case .bababa:
            return ""
        case .baima:
            return ""
        case .ltl:
            return ""
        case .olta:
            return ""
        case .panworld:
            return ""
        case .jiggumun:
            return ""
        case .interlogis:
            return ""
        case .cubleflow:
            return ""
        case .kse:
            return ""
        case .stheshipping:
            return ""
        case .goldsnaps:
            return ""
        case .mtinter:
            return ""
        }
    }
    
    var logo: Logo {
        switch self {
        case .cj, .cupost, .daesin, .dhl, .ems, .fedex, .gsi, .gspostbox, .hanjin, .hapdong, .ilyana, .koreapost, .kyeongdong, .logen, .lotte, .lxpantos, .nonghyup, .tnt, .ups, .usps:
            return Logo(image: Image("logo_\(self)"), bgColor: Color("bgcolor_\(self)"), fgColor: Color("fgcolor_\(self)"))
        default:
            return Logo(image: Image(systemName: "box.truck.fill"), bgColor: ColorManager.background2, fgColor: ColorManager.black)
        }
    }
}


//case .cj, .cupost, .daesin, .dhl, .ems, .fedex, .gsi, .gspostbox, .hanjin, .hapdong, .ilyana, .koreapost, .kyeongdong, .logen, .lotte, .lxpantos, .nonghyup, .tnt, .ups, .usps

//case  = "cj",
//case "46" = "cupost",
//case "22" = "daesin",
//case "13" = "dhl",
//case "12" = "ems",
//case "21" = "fedex",
//case "41" = "gsi",
//case "24" = "gspostbox",
//case "05" = "hanjin",
//case "32" = "hapdong",
//case "11" = "ilyana",
//case "01" = "koreapost",
//case "23" = "kyeongdong",
//case "06" = "logen",
//case "08" = "lotte",
//case "37" = "lxpantos",
//case "53" = "nonghyup",
//case "25" = "tnt",
//case "14" = "ups",
//case "26" = "usps"
