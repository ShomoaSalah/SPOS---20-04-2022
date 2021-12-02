//
//  OrderDetailsFromTicketOB.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 11/25/21.
//

import Foundation

class OrderDetailsFromTicketOB: Codable {
    let item: ItemsOB?
    let variants: [VariantOB]?
    let modifications: [ModificationOB]?
    let discounts: [DiscountsOB]?
    let taxes: [Tax]?

    init(item: ItemsOB?, variants: [VariantOB]?, modifications: [ModificationOB]?, discounts: [DiscountsOB]?, taxes: [Tax]?) {
        self.item = item
        self.variants = variants
        self.modifications = modifications
        self.discounts = discounts
        self.taxes = taxes
    }
}
