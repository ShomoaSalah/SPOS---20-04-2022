//
//  ItemsOB.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/25/21.
//

import Foundation

class ItemsOB: Codable {
    
    let id, categoryID, userID: Int?
    let name: String?
    let storeTracking: Int?
    let dateExpire, soldBy: String?
    let cost: Int?
    let sku: String?
    let barCode: String?
    let colorID: Int?
    let image: String?
    let priceState: String?
    let colorName: String?
    let categoryName: String?
    let inStock: Int?
    let isChecked: Bool?
    let showInterface: Bool?
    let orderID: Int?
    let price: String?
    let quantity: String?
    let comment: String?
    let displayVariantID: Int?
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "category_id"
        case userID = "user_id"
        case name
        case isChecked = "is_checked"
        case storeTracking = "store_tracking"
        case dateExpire = "date_expire"
        case soldBy = "sold_by"
        case cost, sku
        case barCode = "bar_code"
        case colorID = "color_id"
        case image
        case showInterface = "show_interface"
        case priceState = "price_state"
        case colorName = "color_name"
        case categoryName = "category_name"
        case inStock = "in_stock"
        case orderID = "order_id"
        case price, quantity, comment
        case displayVariantID = "display_variant_id"
    }

    init(id: Int?, categoryID: Int?, userID: Int?, name: String?, storeTracking: Int?, dateExpire: String?, soldBy: String?, cost: Int?, sku: String?, barCode: String?, colorID: Int?, image: String?, priceState: String?, colorName: String?, categoryName: String?, inStock: Int?, isChecked: Bool?, showInterface: Bool?, orderID: Int?, price: String?, quantity: String?, comment: String?, displayVariantID: Int?) {
        self.id = id
        self.isChecked = isChecked
        self.categoryID = categoryID
        self.userID = userID
        self.name = name
        self.showInterface = showInterface
        self.storeTracking = storeTracking
        self.dateExpire = dateExpire
        self.soldBy = soldBy
        self.cost = cost
        self.sku = sku
        self.barCode = barCode
        self.colorID = colorID
        self.image = image
        self.priceState = priceState
        self.colorName = colorName
        self.categoryName = categoryName
        self.inStock = inStock
        self.orderID = orderID
        self.price = price
        self.quantity = quantity
        self.comment = comment
        self.displayVariantID = displayVariantID
    }
}
