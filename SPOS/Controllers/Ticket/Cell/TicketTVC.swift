//
//  TicketTVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/5/21.
//

import UIKit

class TicketTVC: UITableViewCell {
    
    @IBOutlet weak var itemNameLbl: UILabel!
    @IBOutlet weak var itemQantityLbl: UILabel!
    @IBOutlet weak var variantNameLbl: UILabel!
    @IBOutlet weak var modificationDetailsNameLbl: UILabel!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var outOfStockLbl: UILabel!
    @IBOutlet weak var discountImage: UIImageView!
    @IBOutlet weak var orderPriceLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
    private var item: OrderOB! {
        didSet{
            itemNameLbl.text = item.itemName ?? ""
            itemQantityLbl.text = "\(item.quantity ?? 0) x"
            
            
            
            if !(item.variantName?.isEmptyStr ?? true) {
                variantNameLbl.isHidden = false
                variantNameLbl.text = item.variantName ?? ""
            }else {
                variantNameLbl.isHidden = true
            }
            
            
            if !(item.modificationDetailsName?.isEmptyStr ?? true) {
                modificationDetailsNameLbl.text = item.modificationDetailsName ?? ""
                modificationDetailsNameLbl.isHidden = false
            }else {
                modificationDetailsNameLbl.isHidden = true
            }
            
            if !(item.comment?.isEmptyStr ?? true) {
                commentLbl.isHidden = false
                commentLbl.text = item.comment ?? ""
            }else {
                commentLbl.isHidden = true
            }
            
            
            
            if item.isOutOfStock! {
                outOfStockLbl.text = "Only \(item.inStock ?? 0) in stock"
                outOfStockLbl.isHidden = false
            }else {
                outOfStockLbl.isHidden = true
            }
            
            
            if item.containsDiscount! {
                discountImage.isHidden = false
            }else {
                discountImage.isHidden = true
            }

            orderPriceLbl.text = item.orderPrice ?? ""
            
        }
    }
    
    
    func configure(data: OrderOB) {
        self.item = data
    }
}
