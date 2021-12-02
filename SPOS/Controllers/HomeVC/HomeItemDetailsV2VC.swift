//
//  HomeItemDetailsV2VC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 11/17/21.
//

import UIKit
import SVProgressHUD


class HomeItemDetailsV2VC: UIViewController {
    
    @IBOutlet weak var commentTF: UITextField!
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var countLbl: UILabel!
    
    var price = ""
    var quantity = ""
    var displayVariantID: Int?
    var modificationDetailIDs = [Int]()
    var discountIDs = [Int]()
  
    var fromTicket = false
    var taxesID = [Int]()
    var count = 0
    var arrSelectedIndex = [IndexPath]()
    
    var titleArray = ["المتغير",
                      "الاضافات",
                      "الخصومات",
                      "الضرائب"]
    
    var numberOfSectionNew = 0
    var titleArrayNew = [String]()
    var titleArrayNewCount = [String: Int]()
    
    var variantArray = [VariantOB]()
    var modificationArray = [ModificationOB]()
    var discountArray = [DiscountsOB]()
    var taxArray = [Tax]()
   
    var storeID = 0
    var itemId = 0
    var orderId = 0
    
    var titleName = ""
    
    
    var newPrice1 = ""
    var variablePrice1 = "Variable"
    var indexPathRow1 = 0
    var newIndexPath1: IndexPath?
    var indexPathRow11 = 0
    var newIndexPath11: IndexPath?
    
    var originalIndexPath: IndexPath?
    var originalIndexPathRow = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTV()
        addRightButton()
        
        self.title = titleName
        if fromTicket {
            getHomeDetailsFromTicket(order_id: orderId, store_id: storeID)
        }else {
            getHomeDetails(item_id: itemId, store_id: storeID)
        }
       
    }
    
    
    
    func addRightButton() {
        
        let viewFN = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 28))
        viewFN.backgroundColor = .clear
        
        let button1 = UIButton(frame: CGRect(x: 0,y: -4, width: 30, height: 28))
        button1.setTitle("حفظ", for: .normal)
        button1.setTitleColor("0CA7EE".color, for: .normal)
        button1.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button1.addTarget(self, action: #selector(submitSaveAction), for: .touchUpInside)
        viewFN.addSubview(button1)
        
        let rightBarButton = UIBarButtonItem(customView: viewFN)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
    }
    
    
    @objc func submitSaveAction() {
        if fromTicket {
            //edit orde//taxesID r
            submitEditOrderFromTicket(order_id: orderId, price: price, quantity: quantity, variant_detail_id: displayVariantID, modification_detail_ids: modificationDetailIDs, comment: commentTF.text ?? "", discount_ids: discountIDs, tax_ids: taxesID)
        }else {
            //add to ticket
        }
       
    }
    
    @IBAction func countPlus(_ sender: UIButton) {
        count = count+1
        countLbl.text = "\(count)"
    }
    
    @IBAction func countMinus(_ sender: UIButton) {
        if count >= 0 {
            count = count-1
            countLbl.text = "\(count)"
        }
    }
    
    
    
    
}


extension HomeItemDetailsV2VC: UITableViewDataSource, UITableViewDelegate {
    
    func initTV() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = false
        tableView.register(UINib(nibName: "HomeItemDetailsSectionTVC", bundle: nil), forCellReuseIdentifier: "HomeItemDetailsSectionTVC") //Section
        tableView.register(UINib(nibName: "HomeItemDetailsTVC", bundle: nil), forCellReuseIdentifier: "HomeItemDetailsTVC") // Cell for variants & modifications
        tableView.register(UINib(nibName: "ModificationsTVC", bundle: nil), forCellReuseIdentifier: "ModificationsTVC") //Cell for modification
        tableView.register(UINib(nibName: "TaxesTVC", bundle: nil), forCellReuseIdentifier: "TaxesTVC") //Cell for tax
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return titleArrayNew.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        switch titleArrayNew {
        //        case "varient":
        //            return variantArray.count
        //            break
        //        case "taxes":
        //            return taxArray.count
        //            break
        //        case "discounts":
        //            return discountArray.count
        //            break
        //        default:
        //            break
        //        }
        
        if section == 0 {
            return variantArray.count
        } else if section == 1 {
            
            if modificationArray.count > 0 {
                for index in 0...modificationArray.count-1{
                    print("modificationArray[index].modificationDetails?.count ?? 0 \(modificationArray[index].modificationDetails?.count ?? 0)")
                    return modificationArray[index].modificationDetails?.count ?? 0
                }
            }
            return 0
            
        } else if section == 2 {
            return discountArray.count
        } else if section == 3 {
            return taxArray.count
        }
        return 0
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cellHeader = tableView.dequeueReusableCell(withIdentifier: "HomeItemDetailsSectionTVC") as! HomeItemDetailsSectionTVC
        let item = titleArrayNew[section]
        cellHeader.titleLbl.text = item
        
        print("Title Section \(item)")
        
        return cellHeader
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 39.0
    }
    
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 { //Cell for variants
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeItemDetailsTVC", for: indexPath) as! HomeItemDetailsTVC
            cell.selectionStyle = .none
            let item = variantArray[indexPath.row]
            
            cell.descriptionLbl.text = item.name
            
            if item.price == nil {
                cell.countLbl.text = "Variable"
            } else {
                cell.countLbl.text = item.price
            }
            

            
            if item.isSelected ?? false {
                displayVariantID = item.id ?? 0
            }else {
            }
            
            if item.id  == displayVariantID {
                cell.isSelected = true
              
                originalIndexPath = indexPath
                originalIndexPathRow = indexPath.row
                
                cell.containerVieww.backgroundColor = "0CA7EE".color.withAlphaComponent(0.05)
                cell.containerVieww.setBorder(width: 0.5, color: "0CA7EE".cgColor)
                cell.countLbl.textColor = "0CA7EE".color
                cell.descriptionLbl.textColor = "0CA7EE".color

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    tableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
                }
            }else {
                cell.isSelected = false
                cell.containerVieww.backgroundColor = .white
                cell.containerVieww.setBorder(width: 0.5, color: "C3C5CE".cgColor)
                cell.countLbl.textColor = .black
                cell.descriptionLbl.textColor = .black
            }
            
            cell.setSelected(cell.isSelected, animated: true)

            return cell
            
        } else if indexPath.section == 1 { //Cell for modifications
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeItemDetailsTVC", for: indexPath) as! HomeItemDetailsTVC
            cell.selectionStyle = .none

//            var item: ModificationDetail?
            
            if modificationArray.count > 0 {
                for index in 0...modificationArray.count-1{

                    let item = modificationArray[index].modificationDetails?[indexPath.row]
                    
                    cell.descriptionLbl.text = item?.optionName //item.optionsNameString
                    cell.countLbl.text = item?.price ?? ""
                    
                    print("modificationArray \(item)")
                }
            }
            
            
//            let item = modificationArray[indexPath.section].modificationDetails?[indexPath.row]
            
            
            
         
            return cell
            
        } else if indexPath.section == 2 { //Cell for discount
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TaxesTVC", for: indexPath) as! TaxesTVC
            cell.selectionStyle = .none
            
            let item = discountArray[indexPath.row]
            
            
            cell.taxNameLbl.text = item.name
            
            cell.enableTaxSwitch.tag = indexPath.row
            cell.enableTaxSwitch.addTarget(self, action: #selector(enableDiscount), for: .valueChanged)
           
            if item.isChecked ?? true {
                discountIDs.append(item.id ?? 0)
            }
            
            
            if item.isChecked ?? false {
                cell.enableTaxSwitch.isOn = true
            }else {
                cell.enableTaxSwitch.isOn = false
            }
            return cell
            
        } else if indexPath.section == 3 { //Cell for tax
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TaxesTVC", for: indexPath) as! TaxesTVC
            cell.selectionStyle = .none
            
            let item = taxArray[indexPath.row]
            cell.configure(data: item)
            
            if item.isChecked ?? false {
                taxesID.append(item.id ?? 0)
            }else {
                taxesID = taxesID.filter {$0 != item.id ?? 0}
            }
                
            if item.isChecked ?? false {
                cell.enableTaxSwitch.isOn = true
            }else {
                cell.enableTaxSwitch.isOn = false
            }
            
            print("item.isChecked \(item.isChecked ?? false )")
            
            cell.enableTaxSwitch.tag = indexPath.row
            cell.enableTaxSwitch.addTarget(self, action: #selector(enableTax), for: .valueChanged)
          
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    
    @objc func enableDiscount(_ sender: UISwitch){
        let item = discountArray[sender.tag]
        
        if sender.isOn {
            discountIDs.append(item.id ?? 0)
        }else {
            discountIDs = discountIDs.filter {$0 != item.id ?? 0}
        }
        print("discountIDs \(discountIDs)")
        
    }
    
    @objc func enableTax(_ sender: UISwitch){
        let item = taxArray[sender.tag]
        
        if sender.isOn {
            
            taxesID.append(item.id ?? 0)
        }else {
            taxesID = taxesID.filter {$0 != item.id ?? 0}
        }
        print("taxesID 2 \(taxesID)")
    }
    
    
    
    @objc func enableModification(_ sender: UISwitch) {
        let item = discountArray[sender.tag]
        //        if sender.isOn {
        //            modificationsID.append(item.id ?? 0)
        //        }else {
        //            modificationsID = modificationsID.filter {$0 != item.id ?? 0}
        //        }
        //        print("modificationsID \(modificationsID)")
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if indexPath.section == 0 { // variants
            
            let cell = tableView.cellForRow(at: indexPath) as! HomeItemDetailsTVC
            
            let item = variantArray[indexPath.row]
            
            if item.price == nil {
                //OPEN ADD PRICE VIEW
                let vc = UIStoryboard.init(name: "HomeDetailsSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddNewPrice2VC") as! AddNewPrice2VC
                vc.indexPathRow = indexPath.row
                vc.newIndexPath = indexPath
                vc.delegate = self
                vc.fromVarientHome = true
                vc.modalPresentationStyle = .overCurrentContext
                vc.modalTransitionStyle = .crossDissolve
                self.present(vc, animated: true, completion: nil)
     
            } else {
                cell.containerVieww.backgroundColor = "0CA7EE".color.withAlphaComponent(0.05)
                cell.containerVieww.setBorder(width: 0.5, color: "0CA7EE".cgColor)
                cell.countLbl.textColor = "0CA7EE".color
                cell.descriptionLbl.textColor = "0CA7EE".color

                self.displayVariantID = item.id ?? 0

                indexPathRow11 = indexPath.row

                newIndexPath11 = indexPath

                cell.setSelected(true, animated: true)
            }

           
            
           /*
            print("arrSelectedIndex \(arrSelectedIndex)")
            if arrSelectedIndex.contains(indexPath) {
                
                arrSelectedIndex = arrSelectedIndex.filter { $0 != indexPath}
                
                cell.containerVieww.backgroundColor = .white
                cell.containerVieww.setBorder(width: 0.5, color: "C3C5CE".cgColor)
                cell.countLbl.textColor = .black
                cell.descriptionLbl.textColor = .black
                
                tableView.deselectRow(at: indexPath, animated: false)
                cell.setSelected(false, animated: true)

            } else {
                arrSelectedIndex.append(indexPath)
               
                cell.containerVieww.backgroundColor = "0CA7EE".color.withAlphaComponent(0.05)
                cell.containerVieww.setBorder(width: 0.5, color: "0CA7EE".cgColor)
                cell.countLbl.textColor = "0CA7EE".color
                cell.descriptionLbl.textColor = "0CA7EE".color
               
                self.displayVariantID = item.id ?? 0
                cell.setSelected(true, animated: true)
            }
            */
            
            
            
        } else if indexPath.section == 1 { // modifications
            
            let cell = tableView.cellForRow(at: indexPath) as! HomeItemDetailsTVC
          
            
            if modificationArray.count > 0 {
                for index in 0...modificationArray.count-1{

                    let item = modificationArray[index].modificationDetails?[indexPath.row]
                    
                   
                    if arrSelectedIndex.contains(indexPath) {
                        arrSelectedIndex = arrSelectedIndex.filter { $0 != indexPath}
                        tableView.deselectRow(at: indexPath, animated: false)
                     
                        cell.containerVieww.backgroundColor = .white
                        cell.containerVieww.setBorder(width: 0.5, color: "C3C5CE".cgColor)
                        cell.countLbl.textColor = .black
                        cell.descriptionLbl.textColor = .black
                        
                        modificationDetailIDs = modificationDetailIDs.filter {$0 != item?.id}
                        cell.setSelected(false, animated: true)
                        
                    } else {
                        arrSelectedIndex.append(indexPath)
                     
                        cell.containerVieww.backgroundColor = "0CA7EE".color.withAlphaComponent(0.05)
                        cell.containerVieww.setBorder(width: 0.5, color: "0CA7EE".cgColor)
                        cell.countLbl.textColor = "0CA7EE".color
                        cell.descriptionLbl.textColor = "0CA7EE".color
                       
                        modificationDetailIDs.append(item?.id ?? 0)
                        cell.setSelected(true, animated: true)
                        
                    }
                    
                }
            }
             
            
        } else if indexPath.section == 2 { // discounts
            
//            let cell = tableView.cellForRow(at: indexPath) as! TaxesTVC
//            let item = discountArray[indexPath.row]
        
            
            
            
        }else if indexPath.section == 3 { // Taxes
            /*
            let cell = tableView.cellForRow(at: indexPath) as! TaxesTVC
            let item = taxArray[indexPath.row]
            cell.configure(data: item)
            
            if item.isChecked ?? true {
                taxesID.append(item.id ?? 0)
            }
            cell.enableTaxSwitch.tag = indexPath.row
            cell.enableTaxSwitch.addTarget(self, action: #selector(enableTax), for: .valueChanged)
            
//            cell.backgroundViewww.backgroundColor = "0CA7EE".color.withAlphaComponent(0.5)
//            cell.backgroundViewww.setBorder(width: 0.5, color: "0CA7EE".cgColor)
//
            if arrSelectedIndex.contains(indexPath) {
                arrSelectedIndex = arrSelectedIndex.filter { $0 != indexPath}
                tableView.deselectRow(at: indexPath, animated: false)
                //                cell.citySelectedImage.image = UIImage(named: "img-filter-Unselect-City")
                //                cities_uuid = cities_uuid.filter {$0 != item.uuid}
                //                citiesName = citiesName.filter {$0 != item.cityName}
                
                cell.setSelected(false, animated: true)
            } else {
                arrSelectedIndex.append(indexPath)
                //                cell.citySelectedImage.image = UIImage(named: "img-filter-Select-City")
                //                cities_uuid.append(item.uuid ?? "")
                //                citiesName.append(item.cityName ?? "")
                cell.setSelected(true, animated: true)
            }
            */
        }
        
    }
    
    
  
    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//
//        if indexPath.section == 0 { // variants
//
//            let cell = tableView.cellForRow(at: indexPath) as! HomeItemDetailsTVC
//            let item = variantArray[indexPath.row]
//
//            cell.containerVieww.backgroundColor = .white
//            cell.containerVieww.setBorder(width: 0.5, color: "C3C5CE".cgColor)
//            cell.countLbl.textColor = .black
//            cell.descriptionLbl.textColor = .black
//            cell.setSelected(false, animated: true)
//
//        }
//
//    }
//
    
    /*
     @objc func enableTax(_ sender: UISwitch){
         let item = taxArray[sender.tag]
         
         if sender.isOn {
             
             taxesID.append(item.id ?? 0)
         }else {
             taxesID = taxesID.filter {$0 != item.id ?? 0}
         }
         print("taxesID \(taxesID)")
     }
     */
    
}




extension HomeItemDetailsV2VC {
    
    func getHomeDetails(item_id: Int, store_id: Int)  {
        
        let requestUrl = APIConstant.getHomeDetails + "?item_id=\(item_id)&store_id=\(store_id)"
        print("requestUrl get Home Details \(requestUrl)")
        //{{url}}/api/pos/tickets/get_modifications_taxes&discounts?item_id=17&store_id=33
        SVProgressHUD.show()
        
        API.startRequest(url: requestUrl, method: .get, parameters: nil, viewCon: self) { [self] (status, responesObject) in
            
            if status {
                SVProgressHUD.dismiss()
                noDataView.isHidden = true
                do{
                    
                    let object = try JSONDecoder().decode(HomeDetailsOB.self, from: responesObject?.data as! Data)
                    
                    variantArray.append(contentsOf: object.variants!)
                    modificationArray.append(contentsOf: object.modifications!)
                    discountArray.append(contentsOf: object.discounts!)
                    taxArray.append(contentsOf: object.taxes!)
                    
                    
                    titleArrayNew.insert("Varient".localized, at: 0)
                    
                    if modificationArray.count > 0 {
                        
                        for index in 0...modificationArray.count-1 {
                            titleArrayNew.insert(modificationArray[index].name ?? "", at: index+1)
                            
                            
                            numberOfSectionNew = modificationArray[index].modificationDetails?.count ?? 0
                            print("numberOfSectionNew 11 \(numberOfSectionNew)")
                            //object.modifications!.count + 3
                            
                            titleArrayNew.insert("Discounts".localized, at: modificationArray[index].modificationDetails?.count ?? 0)
                            titleArrayNew.insert("Taxes".localized, at: modificationArray[index].modificationDetails!.count+1 ?? 0)
                        }
                        
                        numberOfSectionNew += 3
                       
                        
                        
                       
                    } else {
                        
                        titleArrayNew.insert("Discounts".localized, at: 2)
                        titleArrayNew.insert("Taxes".localized, at: 3)
                    }
                    print("numberOfSectionNew 22 \(numberOfSectionNew) ... \(titleArrayNew)")
                    print("titleArrayNew \(titleArrayNew.count) ... \(titleArrayNew)")
                    print("modificationArray \(modificationArray.count)")
                    
                   
                    
                   
                    
                    
                    tableView.reloadData()
                    
                }catch{
                    
                    self.navigationController?.view.makeToast(error.localizedDescription)
                    print(error.localizedDescription)
                }
                
                
            }
            
            else{
                SVProgressHUD.dismiss()
                noDataView.isHidden = false
                self.navigationController?.view.makeToast((responesObject?.message!)!)
            }
            
        }
        
        
    }
    
    func getHomeDetailsFromTicket(order_id: Int, store_id: Int)  {

        
        let requestUrl = APIConstant.showOrderFromTicket + "?store_id=\(store_id)&order_id=\(order_id)"
        print("requestUrl get Home Details From Ticket \(requestUrl)")
        
        
        SVProgressHUD.show()
        
        API.startRequest(url: requestUrl, method: .get, parameters: nil, viewCon: self) { [self] (status, responesObject) in
            
            if status {
                SVProgressHUD.dismiss()
                noDataView.isHidden = true
                do{
                    
                    let object = try JSONDecoder().decode(OrderDetailsFromTicketOB.self, from: responesObject?.data as! Data)
              
                    titleName = object.item?.name ?? ""
                    price = object.item?.price ?? ""
                    quantity = object.item?.quantity ?? ""
                    self.title = titleName
                    
                    displayVariantID = object.item?.displayVariantID ?? 0
                    
                    print("")
                    variantArray.removeAll()
                    variantArray.append(contentsOf: object.variants!)
                    modificationArray.removeAll()
                    modificationArray.append(contentsOf: object.modifications!)
                    discountArray.removeAll()
                    discountArray.append(contentsOf: object.discounts!)
                    taxArray.removeAll()
                    taxArray.append(contentsOf: object.taxes!)
                    
                    numberOfSectionNew = object.modifications!.count + 3
                    
                    titleArrayNew.insert("Varient".localized, at: 0)
                    titleArrayNew.insert("Modifications".localized, at: 1)
                    titleArrayNew.insert("Discounts".localized, at: 2)
                    titleArrayNew.insert("Taxes".localized, at: 3)
                  
                    titleArrayNew.reversed()
                    print("titleArrayNew \(titleArrayNew.count) ... \(titleArrayNew)")
                    print("modificationArray \(modificationArray.count)")
                    
                    tableView.reloadData()
                    
                }catch{
                    
                    self.navigationController?.view.makeToast(error.localizedDescription)
                    print(error.localizedDescription)
                }
                
                
            }
            
            else{
                SVProgressHUD.dismiss()
                noDataView.isHidden = false
                self.navigationController?.view.makeToast((responesObject?.message!)!)
            }
            
        }
        
        
    }

    func submitEditOrderFromTicket(order_id: Int, price: String, quantity: String?, variant_detail_id: Int?, modification_detail_ids: [Int]?, comment: String?, discount_ids: [Int]?, tax_ids: [Int]?) {
        
        let urlRequest = APIConstant.editOrderFromTicket
        print("urlRequest edit Order From Ticket \(urlRequest)")
        
        var params = [String:Any]()
        params["order_id"] = order_id
        params["price"] = price
        params["quantity"] = quantity
        
        if variant_detail_id ?? 0 > 0 {
            params["variant_detail_id"] = variant_detail_id
        }
       
        params["comment"] = comment
        
        /*
        if modification_detail_ids.count > 0 {
            for index in 0...modification_detail_ids.count-1{
                params["modification_detail_ids[\(index)]"] = modification_detail_ids[index]
            }
        }
       
        if discount_ids.count > 0 {
            for index in 0...discount_ids.count-1{
                params["discount_ids[\(index)]"] = discount_ids[index]
            }
        }
       
        if tax_ids.count > 0 {
            for index in 0...tax_ids.count-1{
                params["tax_ids[\(index)]"] = tax_ids[index]
            }
        }
        */
        
        
        params["modification_detail_ids"] = modification_detail_ids
        params["discount_ids"] = discount_ids
        params["tax_ids"] = tax_ids
        
        print("PARAMS \(params)")
        
        
        SVProgressHUD.show()
        
        
        API.startRequest(url: urlRequest, method: .put, parameters: params, viewCon: self) { [self] (status, responesObject) in
            
            SVProgressHUD.dismiss()
            if status {
                
                self.view.makeToast(responesObject?.message)
                getHomeDetailsFromTicket(order_id: orderId, store_id: storeID)
            }
            
            else{
                self.navigationController?.view.makeToast((responesObject?.message!)!)
            }
            
        }
        
    }
    
    func submitAddToTicketWithAllParam(pos_id: Int,
                           type_id: Int?,
                           type: Int?,
                           price: String?,
                           quantity: Int?,
                           modification_detail_ids: [Int]?,
                           comment: String?,
                           discount_ids: [Int]?,
                           tax_ids: [Int]?,
                           variant_detail_id: Int?) {
        
        
        let urlRequest = APIConstant.addToTicket
        print("urlRequest add To Ticket \(urlRequest)")
        
        var params = [String:Any]()
        params["pos_id"] = pos_id
        params["type_id"] = type_id
        params["type"] = type
        params["price"] = price
        params["quantity"] = quantity
        params["modification_detail_ids"] = modification_detail_ids
        params["comment"] = comment
        params["discount_ids"] = discount_ids
        params["tax_ids"] = tax_ids
        params["variant_detail_id"] = variant_detail_id
        
        print("PARAMS \(params)")
        SVProgressHUD.show()
        
        API.startRequest(url: urlRequest, method: .post, parameters: params, viewCon: self) { [self] (status, responesObject) in
            
            SVProgressHUD.dismiss()
            if status {
                
                do{
                    
                    let object = try JSONDecoder().decode(AddToTicketOB.self, from: responesObject?.data as! Data)

                    
                    addRightButton()
                    postNotificationCenter(.setBadgeValue)
                    
                    self.navigationController?.view.makeToast(responesObject?.message)

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

//MARK: - EXT. Protocol

extension HomeItemDetailsV2VC: AddNewPriceProtocol {
    
    
    func addNewPrice(newPrice: String, indexPathRow: Int, newIndexPath: IndexPath?) {
        print("addNewPrice >> \(newPrice) ... \(indexPathRow) ... \(newIndexPath)")
             
        if !newPrice.isEmptyStr {
            
            let cell = tableView.cellForRow(at: newIndexPath!) as! HomeItemDetailsTVC
            cell.countLbl.text = newPrice
           
            cell.containerVieww.backgroundColor = "0CA7EE".color.withAlphaComponent(0.05)
            cell.containerVieww.setBorder(width: 0.5, color: "0CA7EE".cgColor)
            cell.countLbl.textColor = "0CA7EE".color
            cell.descriptionLbl.textColor = "0CA7EE".color
           
            let item = variantArray[indexPathRow]
            self.displayVariantID = item.id ?? 0
            cell.setSelected(true, animated: true)
            
        } else {
            
//            let cell = tableView.cellForRow(at: newIndexPath1!) as! HomeItemDetailsTVC
//            cell.containerVieww.backgroundColor = "0CA7EE".color.withAlphaComponent(0.05)
//            cell.containerVieww.setBorder(width: 0.5, color: "0CA7EE".cgColor)
//            cell.countLbl.textColor = "0CA7EE".color
//            cell.descriptionLbl.textColor = "0CA7EE".color
//            let item = variantArray[originalIndexPathRow]
//            self.displayVariantID = item.id ?? 0
//            cell.setSelected(true, animated: true)
            
            
            let cell1 = tableView.cellForRow(at: originalIndexPath!) as! HomeItemDetailsTVC
            cell1.countLbl.text = "Variable"

            cell1.containerVieww.backgroundColor = .white
            cell1.containerVieww.setBorder(width: 0.5, color: "C3C5CE".cgColor)
            cell1.countLbl.textColor = .black
            cell1.descriptionLbl.textColor = .black

            cell1.setSelected(false, animated: true)
            
        }
        
        
    }
    
    
    
}
