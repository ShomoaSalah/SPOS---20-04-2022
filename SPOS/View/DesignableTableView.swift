//
//  DesignableTableView.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 11/28/21.
//

import Foundation
import UIKit



@IBDesignable
class DesignableTableView: UITableView {

    @IBInspectable var backgroundImage: UIImage? {
        didSet {
            if let image = backgroundImage {
                let backgroundImage = UIImageView(image: image)
                backgroundImage.contentMode = .scaleToFill
                //UIViewContentMode.ScaleToFill
                backgroundImage.clipsToBounds = false
                self.backgroundView = backgroundImage
            }
        }
    }

}


