//
//  ReceiptsTVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 9/29/21.
//

import UIKit
import SDWebImage

class ReceiptsTVC: UITableViewCell {

    @IBOutlet weak var backgroundCircleView: UIView!
    @IBOutlet weak var paymentIconImage: UIImageView!
    @IBOutlet weak var createdTimeLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var receiptNumLbl: UILabel!
    @IBOutlet weak var refundBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundCircleView.setRounded()
        backgroundCircleView.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    private var item: ReceiptDetailsOB! {
        didSet{
            paymentIconImage.sd_setImage(with: URL(string: item.paymentIcon ?? ""), completed: nil)
            createdTimeLbl.text = item.createdTime ?? ""
            totalLbl.text = item.total ?? ""
            receiptNumLbl.text = item.receiptNum ?? ""
            
            
            if item.refund != nil {
                refundBtn.isHidden = false
            }else {
                refundBtn.isHidden = true
            }
           
        }
    }
    
    
    func configure(data: ReceiptDetailsOB) {
        self.item = data
    }
    
}
