//
//  ShowTaxFromTicketVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 11/24/21.
//

import UIKit
import SVProgressHUD

class ShowTaxFromTicketVC: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    var taxArray = [Tax]()
    var ticketID = 0
   
    var deletedTaxId = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showAllTaxfromTicket(ticket_id: ticketID)
        addRightButton()
        initTV()
    }
    
    func addRightButton() {
        
        let viewFN = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 28))
        viewFN.backgroundColor = .clear
        
        
        let button1 = UIButton(frame: CGRect(x: 0,y: 8, width: 50, height: 28))
        button1.setTitle("Save", for: .normal)
        button1.setTitleColor("0386e8".color, for: .normal)
        button1.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button1.addTarget(self, action: #selector(SubmitDeleteTaxes), for: .touchUpInside)
        
        viewFN.addSubview(button1)
        
        let rightBarButton = UIBarButtonItem(customView: viewFN)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
    }
    
    
    @objc func SubmitDeleteTaxes(){
        
        deleteAllTaxfromTicket(taxes_ids: deletedTaxId)
    }
    
}


//MARK: - TableView

extension ShowTaxFromTicketVC: UITableViewDelegate, UITableViewDataSource {
    
    func initTV(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taxArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowTaxFromTicketTVC", for: indexPath) as! ShowTaxFromTicketTVC
        cell.selectionStyle = .none
        
        let item = taxArray[indexPath.row]
        cell.configure(data: item)
         
        
        cell.taxDeleteBtn.tag = indexPath.row
        cell.taxDeleteBtn.addTarget(self, action: #selector(deleteCell), for: .touchUpInside)
        
        return cell
    }
    
    @objc func deleteCell(_ sender: UIButton) {
        
        let item = taxArray[sender.tag]
        
        deletedTaxId.append(item.id ?? 0)
        print("deletedTaxId \(deletedTaxId)")
        
        let indexPath = IndexPath(row: sender.tag, section: 0)
        
        taxArray.remove(at: sender.tag)
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.reloadData()
    }
    
    
    
}


//MARK: - API Request

extension ShowTaxFromTicketVC {
    
    
    func showAllTaxfromTicket(ticket_id: Int) {
        SVProgressHUD.show()
        
        
        let requestUrl = APIConstant.getTaxesFromTicket + "\(ticket_id)"
        print("requestUrl get Taxes From Ticket \(requestUrl)")
        
        
        
        API.startRequest(url: requestUrl, method: .get, parameters: nil, viewCon: self) { [self] status, responseObject in
            
            if status {
                SVProgressHUD.dismiss()
                
                do{
                    let object = try JSONDecoder().decode(TaxOB.self, from: responseObject?.data as! Data)
                    taxArray = object.taxes ?? [Tax]()
                    
                    
                    tableView.reloadData()
                    
                    
                }catch{
                    self.view.makeToast(responseObject?.message ?? "")
                }
                
            }else {
                SVProgressHUD.dismiss()
                self.view.makeToast(responseObject?.message ?? "")
            }
        }
    }
    
    //deleteTaxesFromTicket
    
    
    func deleteAllTaxfromTicket(taxes_ids: [Int]) {
        SVProgressHUD.show()
        
        var requestUrl = APIConstant.deleteTaxesFromTicket
        
        
        if taxes_ids.count > 0 {
            
            if taxes_ids.count == 1 {
                requestUrl =  requestUrl + "?taxes_ids[0]=\(taxes_ids[0])"
            }else {
                
                for index in 0...taxes_ids.count-1 {
                    
                    if index == taxes_ids.count-1 {
                        requestUrl = requestUrl + "?taxes_ids[\(index)]=\(taxes_ids[index])"
                    }else {
                        requestUrl = requestUrl + "?taxes_ids[\(index)]=\(taxes_ids[index])&"
                    }
                    
                }
                
            }
               
        }
        
        
        print("requestUrl get Taxes From Ticket \(requestUrl)")
        
        
        
        API.startRequest(url: requestUrl, method: .delete, parameters: nil, viewCon: self) { [self] status, responseObject in
            
            if status {
                
                
                showAllTaxfromTicket(ticket_id: ticketID)
                
            }else {
                
                self.view.makeToast(responseObject?.message ?? "")
            }
        }
    }
    
    
}
