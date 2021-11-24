//
//  ModificationsTaxesOB.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/28/21.
//

import Foundation


class ModificationsTaxesOB: Codable {
    
    let categories: [CategorieOB]?
    let colors: [ColorsOB]?
    let modifications: [ModificationOB]?
    let taxes: [Tax]?

    init(modifications: [ModificationOB]?, taxes: [Tax]?, categories: [CategorieOB]?, colors: [ColorsOB]?) {
        self.modifications = modifications
        self.taxes = taxes
        self.categories = categories
        self.colors = colors
    }
}


// MARK: - Modification
class ModificationOB: Codable {
    let id: Int?
    let name: String?
    let userID: Int?
    let optionsNameString: String?
    let modificationDetails: [ModificationDetail]?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case userID = "user_id"
        case optionsNameString = "options_name_string"
        case modificationDetails = "modification_details"
    }

    init(id: Int?, name: String?, userID: Int?, optionsNameString: String?, modificationDetails: [ModificationDetail]?) {
        self.id = id
        self.name = name
        self.userID = userID
        self.optionsNameString = optionsNameString
        self.modificationDetails = modificationDetails
    }
}



// MARK: - ModificationDetail
class ModificationDetail: Codable {
    let id, modificationID: Int?
    let optionName, price: String?

    enum CodingKeys: String, CodingKey {
        case id
        case modificationID = "modification_id"
        case optionName = "option_name"
        case price
    }

    init(id: Int?, modificationID: Int?, optionName: String?, price: String?) {
        self.id = id
        self.modificationID = modificationID
        self.optionName = optionName
        self.price = price
    }
}



