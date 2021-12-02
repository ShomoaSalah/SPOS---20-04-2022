//
//  ShowDiscountFromTicketVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 11/24/21.
//

import UIKit
import SVProgressHUD

class ShowDiscountFromTicketVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var discoountArray = [DiscountsOB]()
    var ticketID = 0
    var deletedDiscountId = [Int]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showAllDiscpuntsfromTicket(ticket_id: ticketID)
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
        
        deleteAllDiscountfromTicket(discounts_ids: deletedDiscountId, ticket_id: ticketID)
        
    }
    


}

//MARK: - TableView

extension ShowDiscountFromTicketVC: UITableViewDelegate, UITableViewDataSource {
    
    func initTV(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discoountArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowDiscountFromTicketTVC", for: indexPath) as! ShowDiscountFromTicketTVC
        cell.selectionStyle = .none
        
        let item = discoountArray[indexPath.row]
        cell.configure(data: item)
         
        
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(deleteCell), for: .touchUpInside)
        
        return cell
    }
    
    @objc func deleteCell(_ sender: UIButton) {
        
        let item = discoountArray[sender.tag]
        
        deletedDiscountId.append(item.id ?? 0)
        print("deletedTaxId \(deletedDiscountId)")
        
        let indexPath = IndexPath(row: sender.tag, section: 0)
        
        discoountArray.remove(at: sender.tag)
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.reloadData()
    }
    
    
    
}


//MARK: - API Request

extension ShowDiscountFromTicketVC {


    func showAllDiscpuntsfromTicket(ticket_id: Int) {
        SVProgressHUD.show()

        let requestUrl = APIConstant.getDiscountFromTicket + "\(ticket_id)"
        print("requestUrl get Discounts From Ticket \(requestUrl)")

        API.startRequest(url: requestUrl, method: .get, parameters: nil, viewCon: self) { [self] status, responseObject in

            if status {
                SVProgressHUD.dismiss()

                do{
                    let object = try JSONDecoder().decode(DiscountTicket.self, from: responseObject?.data as! Data)
                    discoountArray = object.discounts ?? [DiscountsOB]()

                    tableView.reloadData()

                   

                }catch{
                    self.view.makeToast(responseObject?.message ?? "")
                }

            } else {
                SVProgressHUD.dismiss()
                self.view.makeToast(responseObject?.message ?? "")
            }
        }
    }

    func deleteAllDiscountfromTicket(discounts_ids: [Int], ticket_id: Int) {
        SVProgressHUD.show()
        
        var requestUrl = ""
        requestUrl = APIConstant.deleteDiscountFromTicket + "?ticket_id=\(ticket_id)"
       
        if discounts_ids.count > 0 {

//            for index1 in 0...discount_ids.count-1 {
//                  requestUrl = requestUrl + "&discounts_ids[\(index1)]=\(discount_ids[index1])"
//            }
           
            
            if discounts_ids.count == 1 {
                requestUrl = requestUrl + "&discounts_ids[0]=\(discounts_ids[0])"
            }else {

                for index in 0...discounts_ids.count-1 {

                    if index == discounts_ids.count-1 {
                        requestUrl = requestUrl + "&discounts_ids[\(index)]=\(discounts_ids[index])"
                    }else {
                        requestUrl = requestUrl + "&discounts_ids[\(index)]=\(discounts_ids[index])&"
                    }

                }

            }

        }


        print("requestUrl get Discount From Ticket \(requestUrl)")

        API.startRequest(url: requestUrl, method: .delete, parameters: nil, viewCon: self) { [self] status, responseObject in

            if status {

                showAllDiscpuntsfromTicket(ticket_id: ticketID)
                

            }else {

                self.view.makeToast(responseObject?.message ?? "")
            }
        }
    }


}
