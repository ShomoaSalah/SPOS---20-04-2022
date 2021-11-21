//
//  CustomersVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/3/21.
//

import UIKit
import SVProgressHUD


class CustomersVC: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchView: SearchView!
    
    var currentPagee = 1
    var lastPagee = 0
    let refresher = UIRefreshControl()
    var customersArray = [CustomersOB]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initTV()
        self.title = "العملاء"
        
        showAllCustomers(current_page: currentPagee)
        tableView.refreshControl = refresher
        refresher.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        searchView.txtSearch.placeholder = "البحث عن عميل"
        searchView.txtSearch.addTarget(self, action: #selector(searchInCustomers), for: .editingChanged)
 
    }
    
    
    @objc func searchInCustomers(){
        
        submitSearchCustomerList(name: searchView.txtSearch.text ?? "", current_page: currentPagee)
        if searchView.txtSearch.text == "" {
            showAllCustomers(current_page: currentPagee)
        }
    }
    
    
    
    @objc func refreshData(){
        showAllCustomers(current_page: currentPagee)
    }
    
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let scrollViewHeight = scrollView.frame.size.height
        let scrollContentSizeHeight = scrollView.contentSize.height
        let scrollOffset = scrollView.contentOffset.y
        
        if ((scrollOffset + scrollViewHeight) >= (scrollContentSizeHeight)){
            print(currentPagee,lastPagee)
            if currentPagee < lastPagee{
                currentPagee += 1
                self.tableView.tableFooterView = createSpinnerFooter()
                showAllCustomers(current_page: currentPagee)
                tableView.scrollToBottom()
            }
        }
    }
    

    @IBAction func createOneItem(_ sender: UIButton) {
        
        let vc = UIStoryboard.init(name: "DepartmentSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddNewCustomersVC") as! AddNewCustomersVC
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    

}



extension CustomersVC: UITableViewDataSource, UITableViewDelegate {
    
    func initTV() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customersArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomersTVC", for: indexPath) as! CustomersTVC
        cell.selectionStyle = .none
        let item = customersArray[indexPath.row]
        cell.configure(data: item)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "DepartmentSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "EditNewCustomersVC") as! EditNewCustomersVC
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


//MARK: - API Request

extension CustomersVC {
    
    func showAllCustomers(current_page: Int) {
        SVProgressHUD.show()
        
        let requestUrl = APIConstant.getCustomers + "?page=\(current_page )"
        print("requestUrl get Customers \(requestUrl)")
        
        API.startRequest(url: requestUrl, method: .get, parameters: nil, viewCon: self) { [self] status, responseObject in
            
            if status {
                
                if self.refresher.isRefreshing {
                    self.refresher.endRefreshing()
                }
                self.tableView.tableFooterView = nil
                
                do{
                    let object = try JSONDecoder().decode([CustomersOB].self, from: responseObject?.data as! Data)
                   
                 
                    if currentPagee == 1{
                        customersArray.removeAll()
                    }
                    
                    
                    customersArray.append(contentsOf: object)
                    initTV()
                    
                    
                    let pages =  try! JSONDecoder().decode(PagesOB.self, from: responseObject?.pages as! Data)
                    
                    currentPagee = pages.currentPage!
                    lastPagee = pages.lastPage!
                    
                    
                }catch{
                    self.view.makeToast(responseObject?.message ?? "")
                }
                
            }else {
                self.view.makeToast(responseObject?.message ?? "")
            }
        }
    }
    
    func submitSearchCustomerList(name: String, current_page: Int) {
       
        let requestUrl = APIConstant.getCustomers + "?name=\(name)&page=\(current_page)"
        print("requestUrl search Customers \(requestUrl)")
        
        API.startRequest(url: requestUrl, method: .get, parameters: nil, viewCon: self) { [self] status, responseObject in
            
            if self.refresher.isRefreshing {
                self.refresher.endRefreshing()
            }
            
            if status {
                
            
                do{
                    let object = try JSONDecoder().decode([CustomersOB].self, from: responseObject?.data as! Data)

                    if currentPagee == 1{
                        customersArray.removeAll()
                    }
                    
                    
                    customersArray.append(contentsOf: object)
                    initTV()
                    
                    
                    let pages =  try! JSONDecoder().decode(PagesOB.self, from: responseObject?.pages as! Data)
                    
                    currentPagee = pages.currentPage!
                    lastPagee = pages.lastPage!
                     
                }catch{
                    self.view.makeToast(responseObject?.message ?? "")
                }
                
            }else {
                self.view.makeToast(responseObject?.message ?? "")
            }
        }
    }
    
}
