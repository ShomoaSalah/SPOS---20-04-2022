//
//  TicketVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/5/21.
//

import UIKit
import SVProgressHUD
import SDWebImage

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



class TicketVC: BaseVC {
    
    @IBOutlet weak var customerDeleteBtn: UIButton!
    @IBOutlet weak var customerEditBtn: UIButton!
    @IBOutlet weak var customerPhoneLbl: UILabel!
    @IBOutlet weak var customerNameLbl: UILabel!
    @IBOutlet weak var customerImage: UIImageView!
    
    
    @IBOutlet weak var totalPriceLbl: UILabel!
    @IBOutlet weak var headerTV: UIView!
    @IBOutlet weak var taxIncludedLbl: UILabel!
    @IBOutlet weak var taxView: UIView!
    @IBOutlet weak var discountView: UIView!
    @IBOutlet weak var discountLbl: UILabel!
    @IBOutlet weak var taxLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var payBtn: UIButton!
    @IBOutlet weak var ticketEmptyView: UIView!
    
    var diningOptionArray = [DiningOptionOB]()
    var storeID = 0
    var ticketID = 0
    var orderArray = [OrderOB]()
    var customerObjecr: CustomersOB?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "التذكرة"
        initTV()
        initCV()
        addRightButton()
        
    print("ticketID \(ticketID)")
        
        if ticketID == 0 {
            ticketEmptyView.isHidden = false
        }else {
           // ticketEmptyView.isHidden = true
            //showTicketDetails
            if UserHelper.isLogin() {
                storeID = UserHelper.lodeUser()!.storeID ?? 0
                showTicketDetails(store_id: storeID, ticket_id: ticketID)
            }
            
        }
        
        
    }
    
    func setTableViewHeight(){
        var frame = tableView.frame
        frame.size.height = tableView.contentSize.height
        tableView.frame = frame
        tableView.reloadData()
        tableView.layoutIfNeeded()
        tableView.heightAnchor.constraint(equalToConstant: tableView.contentSize.height).isActive = true
    }
    
    func addRightButton(){
        
        let viewFN = UIView(frame: CGRect(x: 0, y: 0, width: 90, height: 40))
        viewFN.backgroundColor = .clear
        
        
        let button1 = UIButton(frame: CGRect(x: 0,y: 5, width: 18, height: 30))
        button1.setImage(UIImage(named: "img-delete"), for: .normal)
        
        button1.addTarget(self, action: #selector(didTapOnDeleteTicket), for: .touchUpInside)
        
        let button2 = UIButton(frame: CGRect(x: 26,y: 8, width: 24, height: 24))
        button2.setImage(UIImage(named: "ic-swap"), for: .normal)
        
        button2.addTarget(self, action: #selector(didTapOnAddNewClient), for: .touchUpInside)
        
        
        let button3 = UIButton(frame: CGRect(x: 58,y: 8, width: 24, height: 24))
        button3.setImage(UIImage(named: "ic-Iconly-Bulk-Filter"), for: .normal)
        
        //        button3.addTarget(self, action: #selector(didTapOnSendReceipt), for: .touchUpInside)
        
        
        viewFN.addSubview(button1)
        viewFN.addSubview(button2)
        viewFN.addSubview(button3)
        
        let rightBarButton = UIBarButtonItem(customView: viewFN)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
    }
    
    @IBAction func showTaxesList(_ sender: UIButton) {
       
        let vc = UIStoryboard.init(name: "TicketSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "ShowTaxFromTicketVC") as! ShowTaxFromTicketVC
        vc.ticketID = self.ticketID //ticketID
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func showDiscountList(_ sender: UIButton) {
    }
    
    //didTapOnAddNewClient
    @objc func didTapOnAddNewClient(){
        let vc = UIStoryboard.init(name: "TicketSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddCustomerToTicketVC") as! AddCustomerToTicketVC
        vc.fromTicket = true
        vc.ticketID = ticketID
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapOnDeleteTicket(){
        //REQUEST DELETE
        clearTicketDetails(ticket_id: ticketID)
    }
    
    @IBAction func didTapOnOpenTickets(_ sender: UIButton) {
        
        let vc = UIStoryboard.init(name: "TicketSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "OpenTicketsVC") as! OpenTicketsVC
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        addNotificationObserver(.openTicket, #selector(openTicket))
        addNotificationObserver(.reloadTicketDetails, #selector(reloadTicketDetails))
        //reloadTicketDetails
    }
    
    @objc func openTicket(){
        print("openTicket")
        ticketEmptyView.isHidden = true
        
    }
    @objc func reloadTicketDetails(){
        print("reloadTicketDetails")
        
        if ticketID == 0 {
            ticketEmptyView.isHidden = false
        }else {
            ticketEmptyView.isHidden = true
            //showTicketDetails
            if UserHelper.isLogin() {
                storeID = UserHelper.lodeUser()!.storeID ?? 0
                showTicketDetails(store_id: storeID, ticket_id: ticketID)
            }
            
        }
    }
    
}

//MARK: - Table View
extension TicketVC: UITableViewDelegate, UITableViewDataSource {
    
    func initTV()  {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "TicketTVC", bundle: nil), forCellReuseIdentifier: "TicketTVC")
        tableView.register(UINib(nibName: "AddNewCustomerToTicketTVC", bundle: nil), forCellReuseIdentifier: "AddNewCustomerToTicketTVC")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TicketTVC", for: indexPath) as! TicketTVC
        cell.selectionStyle = .none
        
        let item = orderArray[indexPath.row]
        cell.configure(data: item)
        
        return cell
    }
    
    
}

//MARK: - Collection View
extension TicketVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func initCV()  {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "TicketCVC", bundle: nil), forCellWithReuseIdentifier: "TicketCVC")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  diningOptionArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TicketCVC", for: indexPath) as! TicketCVC
        let item = diningOptionArray[indexPath.row]
        cell.titleLbl.text = item.name ?? ""
        
        if indexPath.row == 0 {
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredVertically)
            
            //            aqarIDs.append(item.uuid ?? "")
            //            aqarsTitle.append(item.categoryName ?? "")
            
            
        }else {
            cell.isSelected = false
        }
        
        cell.setSelected(isSelected: cell.isSelected)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! TicketCVC
        
        cell.setSelected(isSelected: true)
        //  let item = imagesColor[indexPath.row]
        //        aqarSelectedID = item.uuid ?? ""
        //        aqarSelectedName = item.categoryName ?? ""
        //
        //
        //        aqarIDs.append(item.uuid ?? "")
        //        aqarsTitle.append(item.categoryName ?? "")
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! TicketCVC
        
        cell.setSelected(isSelected: false)
        
        //   let item = imagesColor[indexPath.row]
        
        //        aqarIDs = aqarIDs.filter {$0 != item.uuid}
        //        aqarsTitle = aqarIDs.filter {$0 != item.categoryName}
        
    }
    
    
    
}

//MARK: - API Request -

extension TicketVC {
    
    func showTicketDetails(store_id: Int, ticket_id: Int) {
        SVProgressHUD.show()
        
        
        let requestUrl = APIConstant.showTicket + "?store_id=\(store_id)&ticket_id=\(ticket_id)"
        print("requestUrl show Ticket \(requestUrl)")
        
        API.startRequest(url: requestUrl, method: .get, parameters: nil, viewCon: self) { [self] status, responseObject in
            
            if status {
                
                ticketEmptyView.isHidden = true
                do{
                    let object = try JSONDecoder().decode(TicketDetailsOB.self, from: responseObject?.data as! Data)
                    diningOptionArray = object.diningOptions ?? [DiningOptionOB]()
                    
                    if object.customer == nil{
                        headerTV.isHidden = true
                        tableView.layoutTableHeaderView()
                    }else {
                        
                        customerNameLbl.text = object.customer?.name ?? ""
                        customerPhoneLbl.text = object.customer?.phone ?? ""
                        customerEditBtn.tag = object.customer?.id ?? 0
                        customerEditBtn.addTarget(self, action: #selector(selectAnotherCustomerToTicket), for: .touchUpInside)
                        customerDeleteBtn.tag = object.customer?.id ?? 0
                        customerDeleteBtn.addTarget(self, action: #selector(removeCustomerFromTicket), for: .touchUpInside)
                        
                    }
                    
                    
                    
                    orderArray = object.orders ?? [OrderOB]()
                    tableView.reloadData()
                    
                    totalLbl.text = object.total
                    taxLbl.text = object.taxesValue
                    totalPriceLbl.text = object.total
                    
                    if object.containsDiscounts ?? false  {
                        discountView.isHidden = false
                        discountLbl.text = object.discountsValue ?? ""
                    }else {
                        discountView.isHidden = true
                    }
                    
                    
                    if object.containsTaxes ?? false {
                        taxView.isHidden = false
                        
                        if object.taxIncluded ?? false {
                            taxLbl.text = ""
                            taxIncludedLbl.isHidden = false
                        }else {
                            taxLbl.text = object.taxesValue ?? ""
                            taxIncludedLbl.isHidden = true
                        }
                    }else {
                        taxView.isHidden = true
                    }
                    
                    
                    collectionView.reloadData()
                    
                }catch{
                    self.view.makeToast(responseObject?.message ?? "")
                }
                
            }else {
                ticketEmptyView.isHidden = false
                self.view.makeToast(responseObject?.message ?? "")
            }
        }
    }
    
    
    @objc func selectAnotherCustomerToTicket(_ sender: UIButton) {
        //sender.tag == ID
        //addOrEditCustomerTicket
        let vc = UIStoryboard.init(name: "TicketSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddCustomerToTicketVC") as! AddCustomerToTicketVC
        vc.fromTicket = true
        vc.ticketID = ticketID
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func removeCustomerFromTicket(_ sender: UIButton) {
        //sender.tag == ID
        
        submitRemoveCustomerFromTicket(ticket_id: ticketID)
    }
    
    
    func getProfile(pos_id: Int)  {
        
        let requestUrl = APIConstant.profile + "\(pos_id)"
        print("requestUrl profile \(requestUrl)")
        
        SVProgressHUD.show()
        
        
        API.startRequest(url: requestUrl, method: .get, parameters: nil, viewCon: self) { [self] (status, responesObject) in
            
            
            if status {
                
                do{
                    
                    let object = try JSONDecoder().decode(UserOB.self, from: responesObject?.data as! Data)
                    
                    if object.isDiningOption! {
                        headerTV.isHidden = false
                        tableView.layoutTableHeaderView()
                    }else {
                        headerTV.isHidden = true
                        tableView.layoutTableHeaderView()
                    }
                    
                    
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
    
    func clearTicketDetails(ticket_id: Int) {
        SVProgressHUD.show()
        
        let requestUrl = APIConstant.clearTicket + "\(ticket_id)"
        print("requestUrl clear Ticket \(requestUrl)")
        
        API.startRequest(url: requestUrl, method: .delete, parameters: nil, viewCon: self) { [self] status, responseObject in
            
            if status {
                
                self.view.makeToast(responseObject?.message)
                
                ticketEmptyView.isHidden = false
                
            }else {
                
                self.view.makeToast(responseObject?.message ?? "")
            }
        }
    }
    
    func submitRemoveCustomerFromTicket(ticket_id: Int)  {
        
        let requestUrl = APIConstant.removeCustomerFromTicket + "\(ticket_id)"
        print("requestUrl removeCustomerFromTicket \(requestUrl)")
        
        SVProgressHUD.show()
        
        
        API.startRequest(url: requestUrl, method: .delete, parameters: nil, viewCon: self) { [self] (status, responesObject) in
            
            
            if status {
                
                self.view.makeToast(responesObject?.message)
                headerTV.isHidden = true
                tableView.layoutTableHeaderView()
             
                
                
            }
            
            else{
                self.navigationController?.view.makeToast((responesObject?.message!)!)
            }
            
        }
    }
    
}
