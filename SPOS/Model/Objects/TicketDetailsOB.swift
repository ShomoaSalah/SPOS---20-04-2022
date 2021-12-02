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
    let customer: CustomersOB?
    
    enum CodingKeys: String, CodingKey {
        case diningOptions = "dining_options"
        case orders, customer
        case containsDiscounts = "contains_discounts"
        case containsTaxes = "contains_taxes"
        case taxIncluded = "tax_included"
        case discountsValue = "discounts_value"
        case taxesValue = "taxes_value"
        case total
    }
    
    init(diningOptions: [DiningOptionOB]?, orders: [OrderOB]?, containsDiscounts: Bool?, containsTaxes: Bool?, taxIncluded: Bool?, discountsValue: String?, customer: CustomersOB?, taxesValue: String?, total: String?) {
        self.diningOptions = diningOptions
        self.orders = orders
        self.customer = customer
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
    let name, diningOptionName: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case diningOptionName = "dining_option_name"
    }

    init(id: Int?, name: String?, diningOptionName: String?) {
        self.id = id
        self.name = name
        self.diningOptionName = diningOptionName
    }
}


// MARK: - OrderOB
class OrderOB: Codable {
    let id: Int?
    let quantity: String?
    let comment: String?
    let itemName, orderPrice: String?
    let variantName, modificationDetailsName: String?
    let containsDiscount, isOutOfStock: Bool?
    let inStock: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, quantity, comment
        case itemName = "item_name"
        case orderPrice = "order_price"
        case variantName = "variant_name"
        case modificationDetailsName = "modification_details_name"
        case containsDiscount = "contains_discount"
        case isOutOfStock = "is_out_of_stock"
        case inStock = "in_stock"
    }
    
    init(id: Int?, quantity: String?, comment: String?, itemName: String?, orderPrice: String?, variantName: String?, modificationDetailsName: String?, containsDiscount: Bool?, isOutOfStock: Bool?, inStock: Int?) {
        self.id = id
        self.quantity = quantity
        self.comment = comment
        self.itemName = itemName
        self.orderPrice = orderPrice
        self.variantName = variantName
        self.modificationDetailsName = modificationDetailsName
        self.containsDiscount = containsDiscount
        self.isOutOfStock = isOutOfStock
        self.inStock = inStock
    }
}
