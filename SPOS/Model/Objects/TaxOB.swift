//
//  TaxOB.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 11/24/21.
//

import Foundation
// MARK: - DataClass
class TaxOB: Codable {
    let taxes: [Tax]?

    init(taxes: [Tax]?) {
        self.taxes = taxes
    }
}

// MARK: - Tax
class Tax: Codable {
    let id, userID: Int?
    let name: String?
    let tax: Int?
    let isChecked: Bool?
    let itemCount: String?
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case name, tax
        case isChecked = "is_checked"
        case itemCount = "item_count"
    }

    init(id: Int?, userID: Int?, name: String?, tax: Int?, isChecked: Bool?, itemCount: String?) {
        self.id = id
        self.userID = userID
        self.name = name
        self.tax = tax
        self.isChecked = isChecked
        self.itemCount = itemCount
    }
}

