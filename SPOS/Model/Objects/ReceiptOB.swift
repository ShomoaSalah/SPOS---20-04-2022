//
//  ReceiptOB.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 11/30/21.
//

import Foundation

class ReceiptOB: Codable {
    let showAll: Bool?
    let items: [Item]?

    enum CodingKeys: String, CodingKey {
        case showAll = "show_all"
        case items
    }

    init(showAll: Bool?, items: [Item]?) {
        self.showAll = showAll
        self.items = items
    }
}


class Item: Codable {
    let date: String?
    let receipts: [ReceiptDetailsOB]?

    init(date: String?, receipts: [ReceiptDetailsOB]?) {
        self.date = date
        self.receipts = receipts
    }
}






class ReceiptDetailsOB: Codable {
    let id: Int?
    let total, receiptNum: String?
    let refund: String?
    let paymentIcon: String?
    let createdTime: String?

    enum CodingKeys: String, CodingKey {
        case id, total
        case receiptNum = "receipt_num"
        case refund
        case paymentIcon = "payment_icon"
        case createdTime = "created_time"
    }

    init(id: Int?, total: String?, receiptNum: String?, refund: String?, paymentIcon: String?, createdTime: String?) {
        self.id = id
        self.total = total
        self.receiptNum = receiptNum
        self.refund = refund
        self.paymentIcon = paymentIcon
        self.createdTime = createdTime
    }
}
