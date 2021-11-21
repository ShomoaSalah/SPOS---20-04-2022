//
//  AddToTicketOB.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 11/21/21.
//

import Foundation

class AddToTicketOB: Codable {
    
    let count, ticketID: Int?

    enum CodingKeys: String, CodingKey {
        case count
        case ticketID = "ticket_id"
    }

    init(count: Int?, ticketID: Int?) {
        self.count = count
        self.ticketID = ticketID
    }
}
