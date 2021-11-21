//
//  HomeDetailsOB.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 11/17/21.
//

import Foundation

class HomeDetailsOB: Codable {
    
    let variants: [VariantOB]?
    let modifications: [ModificationOB]?
    let discounts: [DiscountsOB]?
    let taxes: [Tax]?

    init(variants: [VariantOB]?, modifications: [ModificationOB]?, discounts: [DiscountsOB]?, taxes: [Tax]?) {
        self.variants = variants
        self.modifications = modifications
        self.discounts = discounts
        self.taxes = taxes
    }
}

class VariantOB: Codable {
    
    let id, itemID: Int?
    let name: String?
    let price: String?
    let cost, sku, barCode: String?
    let isSelected: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case itemID = "item_id"
        case name, price, cost, sku
        case barCode = "bar_code"
        case isSelected = "is_selected"
    }

    init(id: Int?, itemID: Int?, name: String?, price: String?, cost: String?, sku: String?, barCode: String?, isSelected: Bool?) {
        self.id = id
        self.itemID = itemID
        self.name = name
        self.price = price
        self.cost = cost
        self.sku = sku
        self.barCode = barCode
        self.isSelected = isSelected
    }
    
}
