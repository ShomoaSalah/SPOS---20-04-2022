//
//  SceneDelegate.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 9/28/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window = self.window
        // checkUserLogin()
    }
    
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        
        //CLEAR TICKET
        print("application123application123 sceneDidDisconnect")
    }
    
    /*
     
     
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
     */
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        
        // when open app
        print("application123application123 sceneDidBecomeActive")
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).\
        NotificationCenter.default.post(name: .openPinCodeVC, object: nil)
        
        print("application123application123 sceneWillResignActive")
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        print("application123application123 sceneWillEnterForeground")
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        //play in background
        
        NotificationCenter.default.post(name: .openPinCodeVC, object: nil)
        print("application123application123 sceneDidEnterBackground")
    }
    
    
}

