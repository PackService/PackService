//
//  String.swift
//  PackService
//
//  Created by 박윤환 on 2023/02/20.
//

import Foundation

extension String {
    func mapInfo(_ info: String) -> String {
        if self.isEmpty {
            return info
        }
        return self
    }
    
    //MARK: - String Extension For Phonenumber Formatting
    public func toPhoneNumber() -> String {
        if 4 <= self.count && self.count <= 6 {
            return self.replacingOccurrences(of: "(\\d{3})(\\d+)", with: "$1-$2", options: .regularExpression, range: nil)
        } else if 7 <= self.count && self.count <= 10 {
            return self.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "$1-$2-$3", options: .regularExpression, range: nil)
        } else if self.count == 11 {
            return self.replacingOccurrences(of: "(\\d{3})(\\d{4})(\\d+)", with: "$1-$2-$3", options: .regularExpression, range: nil)
        }
        return self
    }
}
