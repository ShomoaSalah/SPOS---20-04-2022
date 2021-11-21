//
//  TicketDetailsOB.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 11/21/21.
//

import Foundation

class TicketDetailsOB: Codable {
    let diningOptions: [DiningOptionOB]?
    let orders: [OrderOB]?
    let containsDiscounts, containsTaxes, taxIncluded: Bool?
    let discountsValue, taxesValue, total: String?
    
    enum CodingKeys: String, CodingKey {
        case diningOptions = "dining_options"
        case orders
        case containsDiscounts = "contains_discounts"
        case containsTaxes = "contains_taxes"
        case taxIncluded = "tax_included"
        case discountsValue = "discounts_value"
        case taxesValue = "taxes_value"
        case total
    }
    
    init(diningOptions: [DiningOptionOB]?, orders: [OrderOB]?, containsDiscounts: Bool?, containsTaxes: Bool?, taxIncluded: Bool?, discountsValue: String?, taxesValue: String?, total: String?) {
        self.diningOptions = diningOptions
        self.orders = orders
        self.containsDiscounts = containsDiscounts
        self.containsTaxes = containsTaxes
        self.taxIncluded = taxIncluded
        self.discountsValue = discountsValue
        self.taxesValue = taxesValue
        self.total = total
    }
}



// MARK: - DiningOptionOB
class DiningOptionOB: Codable {
    let id: Int?
    let name: String?
    
    init(id: Int?, name: String?) {
        self.id = id
        self.name = name
    }
}


// MARK: - OrderOB
class OrderOB: Codable {
    let id, quantity: Int?
    let comment: String?
    let itemName, orderPrice: String?
    let variantName, modificationDetailsName: String?
    let containsDiscount, isOutOfStock: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, quantity, comment
        case itemName = "item_name"
        case orderPrice = "order_price"
        case variantName = "variant_name"
        case modificationDetailsName = "modification_details_name"
        case containsDiscount = "contains_discount"
        case isOutOfStock = "is_out_of_stock"
    }
    
    init(id: Int?, quantity: Int?, comment: String?, itemName: String?, orderPrice: String?, variantName: String?, modificationDetailsName: String?, containsDiscount: Bool?, isOutOfStock: Bool?) {
        self.id = id
        self.quantity = quantity
        self.comment = comment
        self.itemName = itemName
        self.orderPrice = orderPrice
        self.variantName = variantName
        self.modificationDetailsName = modificationDetailsName
        self.containsDiscount = containsDiscount
        self.isOutOfStock = isOutOfStock
    }
}
