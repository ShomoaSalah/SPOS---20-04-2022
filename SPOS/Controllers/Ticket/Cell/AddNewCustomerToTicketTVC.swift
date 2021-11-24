//
//  AddNewCustomerToTicketTVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 11/22/21.
//

import UIKit

class AddNewCustomerToTicketTVC: UITableViewCell {

    @IBOutlet weak var customerImage: UIImageView!
    @IBOutlet weak var customerNameLbl: UILabel!
    @IBOutlet weak var customerContactLbl: UILabel!
    
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
