//
//  HomeItemDetailsV2VC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 11/17/21.
//

import UIKit
import SVProgressHUD

class HomeItemDetailsV2VC: UIViewController {
    
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var countLbl: UILabel!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTV()
        addRightButton()
        
        
        getHomeDetails(item_id: itemId, store_id: storeID)
    }
    
    
    
    func addRightButton() {
        
        let viewFN = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 28))
        viewFN.backgroundColor = .clear
        
        
        let button1 = UIButton(frame: CGRect(x: 0,y: -4, width: 30, height: 28))
        button1.setTitle("حفظ", for: .normal)
        button1.setTitleColor("0CA7EE".color, for: .normal)
        button1.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        
        viewFN.addSubview(button1)
        
        let rightBarButton = UIBarButtonItem(customView: viewFN)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
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
        }else if section == 1 {
            return modificationArray.count
        }else if section == 2 {
            return discountArray.count
        }else if section == 3 {
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
            cell.countLbl.text = item.price
            cell.descriptionLbl.text = item.name
            
            return cell
            
        } else if indexPath.section == 1 { //Cell for modifications
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeItemDetailsTVC", for: indexPath) as! HomeItemDetailsTVC
            cell.selectionStyle = .none
            let item = modificationArray[indexPath.row]
            
            cell.countLbl.text = item.optionsNameString
            //            cell.descriptionLbl.text = item.modificationDetails
            
            return cell
            
        } else if indexPath.section == 2 { //Cell for discount
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TaxesTVC", for: indexPath) as! TaxesTVC
            cell.selectionStyle = .none
            
            let item = discountArray[indexPath.row]
            
            
            cell.taxNameLbl.text = item.name
            
            if item.isEnabled ?? false {
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
            
            
            if item.isChecked ?? true {
                taxesID.append(item.id ?? 0)
            }
            cell.enableTaxSwitch.tag = indexPath.row
            cell.enableTaxSwitch.addTarget(self, action: #selector(enableTax), for: .valueChanged)
            
            return cell
        }
        return UITableViewCell()
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
    
    @objc func enableTax(_ sender: UISwitch){
        let item = taxArray[sender.tag]
        
        if sender.isOn {
            
            taxesID.append(item.id ?? 0)
        }else {
            taxesID = taxesID.filter {$0 != item.id ?? 0}
        }
        print("taxesID \(taxesID)")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //modificationsID
        
        if indexPath.section == 0 {
            
            let cell = tableView.cellForRow(at: indexPath) as! HomeItemDetailsTVC
            let item = variantArray[indexPath.row]
            
            
            print("arrSelectedIndex \(arrSelectedIndex)")
            if arrSelectedIndex.contains(indexPath) {
                
                arrSelectedIndex = arrSelectedIndex.filter { $0 != indexPath}
                cell.containerVieww.backgroundColor = .white//"0CA7EE".color.withAlphaComponent(0.5)
                cell.containerVieww.setBorder(width: 0.5, color: "C3C5CE".cgColor)
                
                tableView.deselectRow(at: indexPath, animated: false)
                //                cell.citySelectedImage.image = UIImage(named: "img-filter-Unselect-City")
                //                cities_uuid = cities_uuid.filter {$0 != item.uuid}
                //                citiesName = citiesName.filter {$0 != item.cityName}
                
                cell.setSelected(false, animated: true)
            } else {
                arrSelectedIndex.append(indexPath)
                cell.containerVieww.backgroundColor = "0CA7EE".color.withAlphaComponent(0.5)
                cell.containerVieww.setBorder(width: 0.5, color: "0CA7EE".cgColor)
                //                cell.citySelectedImage.image = UIImage(named: "img-filter-Select-City")
                //                cities_uuid.append(item.uuid ?? "")
                //                citiesName.append(item.cityName ?? "")
                cell.setSelected(true, animated: true)
            }
            
            
        } else if indexPath.section == 1 {
            
            let cell = tableView.cellForRow(at: indexPath) as! HomeItemDetailsTVC
            let item = modificationArray[indexPath.row]
            
            cell.containerVieww.backgroundColor = "0CA7EE".color.withAlphaComponent(0.5)
            cell.containerVieww.setBorder(width: 0.5, color: "0CA7EE".cgColor)
            
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
            
            
        }else if indexPath.section == 2 {
            let cell = tableView.cellForRow(at: indexPath) as! ModificationsTVC
            let item = modificationArray[indexPath.row]
            
            cell.backgroundViewww.backgroundColor = "0CA7EE".color.withAlphaComponent(0.5)
            cell.backgroundViewww.setBorder(width: 0.5, color: "0CA7EE".cgColor)
            
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
            
        }else if indexPath.section == 3 {
            let cell = tableView.cellForRow(at: indexPath) as! TaxesTVC
            let item = modificationArray[indexPath.row]
            
            cell.backgroundViewww.backgroundColor = "0CA7EE".color.withAlphaComponent(0.5)
            cell.backgroundViewww.setBorder(width: 0.5, color: "0CA7EE".cgColor)
            
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
            
        }
        
    }
    
    
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
                    
                    numberOfSectionNew = object.modifications!.count + 3
                    
                    titleArrayNew.insert("varient".localized, at: 0)
                    titleArrayNew.insert("modifications".localized, at: 1)
                    titleArrayNew.insert("discounts".localized, at: 2)
                    titleArrayNew.insert("taxes".localized, at: 3)
                    //                    titleArrayNewCount["varient".localized] = variantArray.count
                    
                    /*
                     if object.modifications!.count != 0 {
                     for index in 0...object.modifications!.count-1{
                     titleArrayNew.insert(object.modifications![index].name ?? "", at: index+1)
                     
                     //                            titleArrayNewCount[object.modifications![index].name!] = object.modifications!.count
                     }
                     
                     
                     if discountArray.count != 0 {
                     titleArrayNew.insert("discounts".localized, at: object.modifications!.count)
                     //                            titleArrayNewCount["discounts".localized] = discountArray.count
                     
                     }else {
                     titleArrayNew.insert("taxes".localized, at: object.modifications!.count)
                     //                            titleArrayNewCount["taxes".localized] = discountArray.count
                     }
                     
                     if taxArray.count != 0 {
                     titleArrayNew.insert("taxes".localized, at: object.modifications!.count+1)
                     }else {
                     
                     }
                     
                     //                        titleArrayNew.insert("discounts".localized, at: object.modifications!.count)
                     //                        titleArrayNew.insert("taxes".localized, at: object.modifications!.count+1)
                     }
                     
                     else {
                     
                     if discountArray.count != 0 {
                     titleArrayNew.insert("discounts".localized, at: 1)
                     }else {
                     titleArrayNew.insert("taxes".localized, at: 2)
                     }
                     
                     if taxArray.count != 0 {
                     titleArrayNew.insert("taxes".localized, at: object.modifications!.count+1)
                     }else {
                     
                     }
                     }
                     
                     */
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
    
}
