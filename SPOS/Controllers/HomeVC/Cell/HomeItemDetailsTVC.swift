//
//  HomeItemDetailsTVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/3/21.
//

import UIKit

class HomeItemDetailsTVC: UITableViewCell {

    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var containerVieww: UIView!
    
   
    var moreCallBack:((Int,String,IndexPath)->Void)? // String > Price, Int > IndexPath.row
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
        if selected {
            containerVieww.backgroundColor = "0CA7EE".color.withAlphaComponent(0.05)
            containerVieww.setBorder(width: 0.5, color: "0CA7EE".cgColor)
            countLbl.textColor = "0CA7EE".color
            descriptionLbl.textColor = "0CA7EE".color
        } else {
            containerVieww.backgroundColor = .white
            containerVieww.setBorder(width: 0.5, color: "C3C5CE".cgColor)
            countLbl.textColor = .black
            descriptionLbl.textColor = .black
        }
        
    }
    
    
    
}
