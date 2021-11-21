//
//  DiscountsOB.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/27/21.
//

import Foundation

class DiscountsOB: Codable {
    
    let id, userID: Int?
    let name, type, amountValue: String?
    let amount: String?
    let isEnabled: Bool?
    
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case name, type, amount
        case amountValue = "amount_value"
        case isEnabled = "is_enabled"
    }

    init(id: Int?, userID: Int?, name: String?, type: String?, amountValue: String?, amount: String?, isEnabled: Bool?) {
        self.id = id
        self.userID = userID
        self.name = name
        self.type = type
        self.amountValue = amountValue
        self.amount = amount
        self.isEnabled = isEnabled
    }
}
