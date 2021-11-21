//
//  SelectCountryTVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 11/16/21.
//

import UIKit
import DropDown


class SelectCountryTVC: DropDownCell {

    @IBOutlet weak var selectedCountryNameLbl: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var backgroundViewww: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
