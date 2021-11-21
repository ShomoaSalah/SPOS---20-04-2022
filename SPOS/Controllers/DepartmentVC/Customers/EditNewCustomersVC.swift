//
//  EditNewCustomersVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/3/21.
//

import UIKit
import DropDown
import SVProgressHUD
import IQKeyboardManagerSwift

class EditNewCustomersVC: BaseVC, UITextFieldDelegate {
    
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
    
    var customerId = 0
    var customersObject: CustomersOB?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneTF.delegate = self
        customerCodeTF.delegate = self
        self.title = "تعديل العميل"
        getCountries()
        showCustomerDetails(customer_id: customerId)
        
        
        
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
    
    
    @IBAction func selectCountry(_ sender: UIButton) {
        openCountryMenu()
    }
    
  
    
    func openCountryMenu(){
        
        dropDownCountry.layer.cornerRadius = 10
        dropDownCountry.backgroundColor = .white
 
        dropDownCountry.anchorView = countryView
        dropDownCountry.width = 320
        dropDownCountry.bottomOffset = CGPoint(x: 0, y:(dropDownCountry.anchorView?.plainView.bounds.height)!)
       
        
      //  dropDownCountry.cellNib = UINib(nibName: "SelectCountryTVC", bundle: nil)
       
        /*dropDownCountry.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? SelectCountryTVC else { return }
            
            
            cell.backgroundViewww.backgroundColor = .red
            // Setup your custom UI components
//         cell.logoImageView.image = UIImage(named: "logo_\(index % 10)")
            
        }*/
        
        
        
//        dropDownCountry.forEach {
//            /*** FOR CUSTOM CELLS ***/
//            $0.cellNib = UINib(nibName: "SelectCountryTVC", bundle: nil)
//
//            $0.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
//                guard let cell = cell as? MyCell else { return }
//
//                // Setup your custom UI components
////                cell.logoImageView.image = UIImage(named: "logo_\(index % 10)")
//
//            }
//            /*** ---------------- ***/
//        }
        
        
        
        dropDownCountry.dataSource = self.countryArrayString
        
//
//        if self.countryArrayString.count != 0 {
//
//            for index in 1...countryArrayString.count{
//                if index == countrySelectedIndex {
//                    dropDownCountry.selectRow(at: index)
//                    dropDownCountry.selectedTextColor = .red
//
//
//                }
//            }
//
//        }
           
       

        dropDownCountry.selectionAction = { [unowned self] (index: Int, item: String) in
            
            countrySelectedLbl.text = item
            countrySelectedIndex = countryDics[item] ?? 0
            
           
            print("countrySelectedIndex \(countrySelectedIndex)")
            
        }
        dropDownCountry.show()
    }
    
    
    
    @IBAction func submitEditing(_ sender: UIButton) {
      
        
        editNewCustomer(customerId: customerId, name: (nameTF.text ?? customersObject?.name)!, email: (emailTF.text ?? customersObject?.email)!, phone: (phoneTF.text ?? customersObject?.phone)!, address: (addressTF.text ?? customersObject?.address)!, city: (cityTF.text ?? customersObject?.city)!, region: (regionTF.text ?? customersObject?.region)!, postal_code: (postalCodeTF.text ?? customersObject?.postalCode)!, country_id: (countrySelectedIndex ?? customersObject?.countryId)!, customer_code: (customerCodeTF.text ?? customersObject?.customerCode)!, note: (noteTV.text ?? customersObject?.note)!)
    }
    
    
    @IBAction func submitDeleting(_ sender: UIButton) {
        deleteCustomer(customer_id: customerId)
    }
    
    
}


extension EditNewCustomersVC {
    
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
                
               
                print("countrySelectedIndex \(countrySelectedIndex)")
            }else {
                self.navigationController?.view.makeToast(msg)
            }
        }
    }
    
    func showCustomerDetails(customer_id: Int) {
        
        SVProgressHUD.show()
        
        let requestUrl = APIConstant.showCustomers + "\(customer_id)"
        print("requestUrl show Customers \(requestUrl)")
        
        API.startRequest(url: requestUrl, method: .get, parameters: nil, viewCon: self) { [self] status, responseObject in
            
            if status {
                
                
                do{
                    let object = try JSONDecoder().decode(CustomersOB.self, from: responseObject?.data as! Data)
                    customersObject = object
                    
                    
                    nameTF.text = customersObject!.name
                    emailTF.text =  customersObject!.email
                    phoneTF.text = customersObject!.phone
                    cityTF.text = customersObject!.city
                    regionTF.text = customersObject!.region
                    postalCodeTF.text = customersObject!.postalCode
                    addressTF.text = customersObject!.address
                    customerCodeTF.text = customersObject!.customerCode
                    noteTV.text = customersObject!.note
//                    countrySelectedLbl.text = customersObject.co
                    countrySelectedIndex = customersObject!.countryId ?? 0
                    
                }catch{
                    self.view.makeToast(responseObject?.message ?? "")
                }
                
            }else {
                self.view.makeToast(responseObject?.message ?? "")
            }
        }
    }
    
    func editNewCustomer(customerId: Int, name: String, email: String, phone: String, address: String, city: String?, region: String?, postal_code: String?, country_id: Int?, customer_code: String?, note: String?)  {
        let urlRequest = APIConstant.editCustomers
        print("urlRequest edit Customers \(urlRequest)")
        
        var params = [String:Any]()
        params["customer_id"] = customerId
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
        
        API.startRequest(url: urlRequest, method: .put, parameters: params, viewCon: self) { [self] (status, responesObject) in
            
            SVProgressHUD.dismiss()
            if status {
                
                do{
                    
                    let object = try JSONDecoder().decode(CustomersOB.self, from: responesObject?.data as! Data)
                
                    customersObject = object
                                        
                    postNotificationCenter(.reloadCustomers)
                    self.navigationController?.view.makeToast(responesObject?.message)
                   // self.navigationController?.popViewController(animated: true)
                      
                    
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
    
    
    func deleteCustomer(customer_id: Int) {
        
        SVProgressHUD.show()
        
        let requestUrl = APIConstant.deleteCustomers + "\(customer_id)"
        print("requestUrl delete Customer \(requestUrl)")
        
        API.startRequest(url: requestUrl, method: .delete, parameters: nil, viewCon: self) { [self] status, responseObject in
            
            if status {
                
                self.view.makeToast(responseObject?.message)
                postNotificationCenter(.reloadCustomers)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.navigationController?.popViewController(animated: true)
                }
                
            }else {
                self.view.makeToast(responseObject?.message ?? "")
            }
        }
    }

}
