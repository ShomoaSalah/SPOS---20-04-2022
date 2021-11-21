//
//  CustomersOB.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 11/11/21.
//

import Foundation

class CustomersOB: Codable {
    
    let id: Int?
    let name, contacts: String?
    let lastVisitDate: String?
    let points, contactsInfo: String?
    let visits: Int?
    let email, phone: String?
    let customerCode, note: String?
    let address, city, region: String?
    let postalCode: String?
    let countryId: Int?
    
    enum CodingKeys: String, CodingKey {
        
        case name, email, phone, contacts, address, city, region
        case customerCode = "customer_code"
        case note, id, points
        case postalCode = "postal_code"
        case contactsInfo = "contacts_info"
        case visits
        case countryId = "country_id"
        case lastVisitDate = "last_visit_date"
        
    }
    
    init(name: String?, email: String?, phone: String?, customerCode: String?, note: String?, id: Int?, points: String?, contactsInfo: String?, visits: Int?, lastVisitDate: String?, contacts: String?, address: String?, city: String?, region: String?, postalCode: String?, countryId: Int?) {
        self.name = name
        self.email = email
        self.phone = phone
        self.address  = address
        self.city = city
        self.postalCode = postalCode
        self.region = region
        self.contacts = contacts
        self.customerCode = customerCode
        self.note = note
        self.id = id
        self.countryId = countryId
        self.points = points
        self.contactsInfo = contactsInfo
        self.visits = visits
        self.lastVisitDate = lastVisitDate
    }
    
}
