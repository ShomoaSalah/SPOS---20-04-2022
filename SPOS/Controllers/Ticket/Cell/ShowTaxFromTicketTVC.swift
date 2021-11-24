//
//  ShowTaxFromTicketTVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 11/24/21.
//

import UIKit

class ShowTaxFromTicketTVC: UITableViewCell {

    @IBOutlet weak var taxNameLbl: UILabel!
    @IBOutlet weak var taxDescriptionLbl: UILabel!
    @IBOutlet weak var taxPercentageLbl: UILabel!
    @IBOutlet weak var taxDeleteBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
 
    
    private var item: Tax! {
        didSet{
         
            taxNameLbl.text = item.name ?? ""
            taxDescriptionLbl.text = item.itemCount ?? ""
            taxPercentageLbl.text = item.tax?.description ?? ""
            
        }
    }
    
    
    func configure(data: Tax) {
        self.item = data
    }

}
