//
//  AddNewPriceVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 11/10/21.
//

import UIKit
import SVProgressHUD

/*
protocol AddNewPriceProtocol {
    func addNewPrice(newPrice: String, indexPathRow: Int, newIndexPath: IndexPath?)
}


class AddNewPriceVC: UIViewController {
    
    @IBOutlet weak var priceTF: UITextField!
    
    var store_id = 0
    var type_id = 0
    var type = 0
    var quantity = 1
    var posID = 0
    
    var indexPathRow = 0
    var newIndexPath: IndexPath?
    var delegate: AddNewPriceProtocol?
    
    var fromVarientHome = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func submit(_ sender: UIButton) {
        
        guard let price = priceTF.text, !price.isEmptyStr else {
            self.navigationController?.view.makeToast(NSLocalizedString("priceRequired", comment: ""))
            return
        }
        
        if fromVarientHome {
            
            self.delegate?.addNewPrice(newPrice: priceTF.text!, indexPathRow: indexPathRow, newIndexPath: newIndexPath)
            self.navigationController?.popViewController(animated: true)
        }else {
            submitPriceTOTicket(pos_id: self.posID, store_id: store_id, type_id: type_id, type: type, price: priceTF.text!, quantity: 1)
        }
        
    }
}


extension AddNewPriceVC {
    
    func submitPriceTOTicket(pos_id: Int, store_id: Int, type_id: Int, type: Int, price: String, quantity: Int) {
        
        let urlRequest = APIConstant.addToTicket
        print("urlRequest addToTicket \(urlRequest)")
        
        var params = [String:Any]()
        params["pos_id"] = pos_id
        params["store_id"] = store_id
        params["type_id"] = type_id
        params["type"] = type
        params["price"] = price
        params["quantity"] = quantity
        
        print("PARAMS \(params)")
        SVProgressHUD.show()
        
        API.startRequest(url: urlRequest, method: .post, parameters: params, viewCon: self) { [self] (status, responesObject) in
            
            SVProgressHUD.dismiss()
            if status {
                self.view.makeToast(responesObject?.message)
                DispatchQueue.main.asyncAfter(deadline: .now()+0.4) {
                    self.navigationController?.popViewController(animated: true)
                }
            }
            
            else{
                self.navigationController?.view.makeToast((responesObject?.message!)!)
            }
            
        }
    }
    
    
}
*/
