//
//  ShowDiscountFromTicketTVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 11/24/21.
//

import UIKit

class ShowDiscountFromTicketTVC: UITableViewCell {

    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var discountPriceLbl: UILabel!
    @IBOutlet weak var discoutItemCountLbl: UILabel!
    @IBOutlet weak var discountTitleLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private var item: DiscountsOB! {
        didSet{
         
            discountTitleLbl.text = item.name ?? ""
            discoutItemCountLbl.text = item.itemCount ?? ""
            discountPriceLbl.text = item.value ?? "" 
            
        }
    }
    
    
    func configure(data: DiscountsOB) {
        self.item = data
    }
    
}
