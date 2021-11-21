//
//  AddCustomerToTicketTVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/5/21.
//

import UIKit

class AddCustomerToTicketTVC: UITableViewCell {

    @IBOutlet weak var customerNameLbl: UILabel!
    @IBOutlet weak var customerContactsLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    private var item: CustomersOB! {
        didSet{
            customerNameLbl.text = item.name
            customerContactsLbl.text = item.contacts
        }
    }


    func configure(data: CustomersOB) {
        self.item = data
    }
    
}
