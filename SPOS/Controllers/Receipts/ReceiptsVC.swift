//
//  ReceiptsVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 9/29/21.
//

import UIKit
import SVProgressHUD

class ReceiptsVC: BaseVC {
    
    @IBOutlet weak var searchView: SearchView!
    @IBOutlet weak var tableView: UITableView!
    var receiptArray = [ReceiptOB]()
    let receiptsArray = [ReceiptDetailsOB]()
    var itemArray = [Item]()
    
    
    var posID = 0
    var currentPagee = 1
    var lastPagee = 0
    let refresher = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initTV()
        
        if UserHelper.isLogin() {
            posID = UserHelper.lodeUser()!.posID ?? 0
            showReceiptList(pos_id: posID, currentPage: currentPagee)
        }
        searchView.txtSearch.placeholder = "البحث من خلال رقم الفاتورة"
        searchView.txtSearch.addTarget(self, action: #selector(searchInReceipts), for: .editingChanged)
        addLeftButton()
    }
    
    
    @objc func searchInReceipts(){
        
        searchInReceiptList(pos_id: posID, currentPage: currentPagee, receiptNum: searchView.txtSearch.text ?? "")

        if searchView.txtSearch.text == "" {
            showReceiptList(pos_id: posID, currentPage: currentPagee)
        }
    }
    
    
    
    func addLeftButton() {
        
        let viewFN = UIView(frame: CGRect(x: 0, y: 0, width: 86, height: 28))
        viewFN.backgroundColor = .clear
        
        
        let button1 = UIButton(frame: CGRect(x: 0,y: -4, width: 40, height: 28))
        button1.setImage(UIImage(named: "img-logo4"), for: .normal)
        button1.contentMode = .scaleAspectFill
        
        let button2 = UIButton(frame: CGRect(x: 44,y: -4, width: 28, height: 28))
        button2.setImage(UIImage(named: "img-logo445"), for: .normal)
        button2.contentMode = .scaleAspectFill
      
        viewFN.addSubview(button1)
        viewFN.addSubview(button2)
        
        let leftBarButton = UIBarButtonItem(customView: viewFN)
        self.navigationItem.leftBarButtonItem = leftBarButton
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowOffset = CGSize(width: 0, height: 5)
        self.navigationController?.navigationBar.shadowColor = "CECECE".color.withAlphaComponent(0.5)
        self.navigationController?.navigationBar.shadowOpacity = 0.8
        
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
                showReceiptList(pos_id: posID, currentPage: currentPagee)
                tableView.scrollToBottom()
            }
        }
    }
    
}

extension ReceiptsVC: UITableViewDataSource, UITableViewDelegate {
    
    func initTV() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "ReceiptsTVC", bundle: nil), forCellReuseIdentifier: "ReceiptsTVC")
        tableView.register(UINib(nibName: "ReceiptsSectionTVC", bundle: nil), forCellReuseIdentifier: "ReceiptsSectionTVC")
        
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return itemArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray[section].receipts!.count
        //receiptArray[section].receipts?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cellHeader = tableView.dequeueReusableCell(withIdentifier: "ReceiptsSectionTVC") as! ReceiptsSectionTVC
        let titleRec = itemArray[section]
        cellHeader.dateLbl.text = titleRec.date ?? ""
        
        return cellHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 43.0
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiptsTVC", for: indexPath) as! ReceiptsTVC
        cell.selectionStyle = .none
        
        //itemArray[section].receipts!.count
        let item = itemArray[indexPath.section].receipts![indexPath.row]

        cell.configure(data: item)

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "ReceiptsSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "ReceiptsDetailsVC") as! ReceiptsDetailsVC
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
  
    }
    
}



//MARK: - API Request

extension ReceiptsVC {
    
    
    func showReceiptList(pos_id: Int, currentPage: Int) {
        SVProgressHUD.show()
        
        let requestUrl = APIConstant.getReceipts + "?pos_id=\(pos_id)&page=\(currentPage)"
        print("requestUrl get Receipts \(requestUrl)")
        
        API.startRequest(url: requestUrl, method: .get, parameters: nil, viewCon: self) { [self] status, responseObject in
            
            if status {
                
                
                if self.refresher.isRefreshing {
                    self.refresher.endRefreshing()
                }
                self.tableView.tableFooterView = nil
                
                
                
                do{
                    let object = try JSONDecoder().decode(ReceiptOB.self, from: responseObject?.data as! Data)
                    
                    
                    if currentPagee == 1{
                        itemArray.removeAll()
                    }
                    itemArray.append(contentsOf: object.items ?? [Item]())
                    
                    
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
    
  
    //{{url}}/api/pos/tickets/receipts?receipt_num=1-1000&pos_id=82&page=1
    
    func searchInReceiptList(pos_id: Int, currentPage: Int, receiptNum: String) {
//        SVProgressHUD.show()
        
        let requestUrl = APIConstant.getReceipts + "?pos_id=\(pos_id)&receipt_num=\(receiptNum)&page=\(currentPage)"
        print("requestUrl get Receipts \(requestUrl)")
        
        API.startRequest(url: requestUrl, method: .get, parameters: nil, viewCon: self) { [self] status, responseObject in
            
            if status {
                
                
                if self.refresher.isRefreshing {
                    self.refresher.endRefreshing()
                }
                self.tableView.tableFooterView = nil
                
                
                
                do{
                    let object = try JSONDecoder().decode(ReceiptOB.self, from: responseObject?.data as! Data)
                    
                    
                    if currentPagee == 1{
                        itemArray.removeAll()
                    }
                    itemArray.append(contentsOf: object.items ?? [Item]())
                    
                    
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
