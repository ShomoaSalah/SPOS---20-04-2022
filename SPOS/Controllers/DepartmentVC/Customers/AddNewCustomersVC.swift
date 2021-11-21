//
//  AddNewCustomersVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/3/21.
//

import UIKit
import DropDown
import SVProgressHUD
import IQKeyboardManagerSwift

class AddNewCustomersVC: BaseVC, UITextFieldDelegate {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var regionTF: UITextField!
    @IBOutlet weak var postalCodeTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    
    @IBOutlet weak var customerCodeTF: UITextField!
    
    @IBOutlet weak var noteTV: IQTextView!
    
    @IBOutlet weak var countrySelectedLbl: UILabel!
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    let dropDownCountry = DropDown()
    var countriess = [CountriesOB]()
    var countryDics = [String:Int]()
    
    var countryArrayString = [String]()
    var countrySelectedIndex = 0
    var customersObject: CustomersOB?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        phoneTF.delegate = self
        customerCodeTF.delegate = self
        self.title = "عميل جديد"
        getCountries()
    }
    
    
    @IBAction func selectCountry(_ sender: UIButton) {
        openCountryMenu()
    }
    
    
    
    // Write Only 15, 40 Digits
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String
    ) -> Bool {
        
        switch textField {
        case phoneTF:
            let resultText = (phoneTF.text as NSString?)?.replacingCharacters(in: range, with: string)
            return phoneTF.isUserInteractionEnabled == (resultText!.count <= 15)
            
        case customerCodeTF:
            let resultText = (customerCodeTF.text as NSString?)?.replacingCharacters(in: range, with: string)
            return customerCodeTF.isUserInteractionEnabled == (resultText!.count <= 40)
            
        default:
            break
        }
        return false
    }
  
    
    func openCountryMenu(){
        
        dropDownCountry.layer.cornerRadius = 10
        dropDownCountry.backgroundColor = .white
        
        dropDownCountry.anchorView = countryView
        dropDownCountry.width = 320
        dropDownCountry.bottomOffset = CGPoint(x: 0, y:(dropDownCountry.anchorView?.plainView.bounds.height)!)
        
        dropDownCountry.dataSource = self.countryArrayString
        
        dropDownCountry.selectionAction = { [unowned self] (index: Int, item: String) in
            
            countrySelectedLbl.text = item
            countrySelectedIndex = countryDics[item] ?? 0
            print("countrySelectedIndex \(countrySelectedIndex)")
            
        }
        dropDownCountry.show()
    }
    
    @IBAction func submitAddNewCustomer(_ sender: UIButton) {
       
        guard let name = nameTF.text, !name.isEmptyStr else {
            self.navigationController?.view.makeToast(NSLocalizedString("nameRequired", comment: ""))
            return
        }
        guard let email = emailTF.text, !email.isEmptyStr else {
            self.navigationController?.view.makeToast(NSLocalizedString("emailRequired", comment: ""))
            return
        }
        guard let phone = phoneTF.text, !phone.isEmptyStr else {
            self.navigationController?.view.makeToast(NSLocalizedString("phoneRequired", comment: ""))
            return
        }
        
        addNewCustomerToServer(name: nameTF.text!, email: emailTF.text!, phone: phoneTF.text!, address: addressTF.text ?? "", city: cityTF.text ?? "", region: regionTF.text ?? "", postal_code: postalCodeTF.text ?? "", country_id: countrySelectedIndex, customer_code: customerCodeTF.text ?? "", note: noteTV.text ?? "")
        
    }
    

}

//MARK: - API Request

extension AddNewCustomersVC {
    
    func getCountries() {
        API.getCountriesList { [self] countries, status, msg in
            
            
            LoadingButton.stopLoading(activityIndicator: loadingIndicator)
            loadingIndicator.isHidden = true
            
            if status {
                countriess = countries
                
                for country in countriess {
                    countryArrayString.append(country.name!)
                    countryDics[country.name!] = country.id
                    countrySelectedIndex = country.id!
                    
                    
                }
                dropDownCountry.dataSource = countryArrayString
                
                
            }else {
                self.navigationController?.view.makeToast(msg)
            }
        }
    }
    
    
    
    
    func addNewCustomerToServer(name: String, email: String, phone: String, address: String, city: String?, region: String?, postal_code: String?, country_id: Int?, customer_code: String?, note: String?)  {
        let urlRequest = APIConstant.addCustomers
        print("urlRequest add Customers \(urlRequest)")
        
        var params = [String:Any]()
        
        params["name"] = name
        params["email"] = email
        params["phone"] = phone
        params["address"] = address
        params["city"] = city
        params["region"] = region
        params["postal_code"] = postal_code
        params["country_id"] = country_id
        params["customer_code"] = customer_code
        params["note"] = note
      
        
        print("PARAMS \(params)")
        SVProgressHUD.show()
        
   
        
        API.startRequest(url: urlRequest, method: .post, parameters: params, viewCon: self) { [self] (status, responesObject) in
            
            SVProgressHUD.dismiss()
            if status {
                
                do{
                    
                    let object = try JSONDecoder().decode(CustomersOB.self, from: responesObject?.data as! Data)
                
                    customersObject = object
                    
                    print("customersObject After Adding \(customersObject)")
                    
                    postNotificationCenter(.reloadCustomers)
                  
                    self.navigationController?.popViewController(animated: true)
                      
                    
                }catch{
                    self.navigationController?.view.makeToast(error.localizedDescription)
                    print(error.localizedDescription)
                }
                
                
            }
            
            else{
                self.navigationController?.view.makeToast((responesObject?.message!)!)
            }
            
        }
        
    }
    
    
}
