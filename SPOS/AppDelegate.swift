//
//  AppDelegate.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 9/28/21.
//

import UIKit
import IQKeyboardManagerSwift
import SVProgressHUD


@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    var hasAlreadyLaunched: Bool!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        IQKeyboardManager.shared.enable = true

        UIFont.overrideInitialize()
        removeBottomLineFromNavigation()
        setFontTypeUINavigationController()
        removeTabBarTopLine()
        setImageForBackArrow()
        customSVProgressHUD()
        
        checkFirstTimeInstallApp()
        
        return true
    }
    
    func checkFirstTimeInstallApp() {
        //retrieve value from local store, if value doesn't exist then false is returned
        hasAlreadyLaunched = UserDefaults.standard.bool(forKey: "hasAlreadyLaunched")
        //check first launched
        if (hasAlreadyLaunched){
            hasAlreadyLaunched = true
        }else{
            UserDefaults.standard.set(true, forKey: "hasAlreadyLaunched")
        }
    }
    
    func sethasAlreadyLaunched(){
        hasAlreadyLaunched = true
    }
    
    
    func customSVProgressHUD()  {
        SVProgressHUD.setBackgroundColor(.clear)
        SVProgressHUD.setForegroundColor("0386E8".color)
        SVProgressHUD.setDefaultMaskType(.black)
    }
    
    func removeBottomLineFromNavigation() {
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
//            appearance.configureWithOpaqueBackground()
            
            appearance.configureWithDefaultBackground()
            appearance.backgroundImage = UIImage()
            appearance.shadowImage = UIImage()
        
            UINavigationBar.appearance().setBackgroundImage(appearance.backgroundImage, for: .default)
            UINavigationBar.appearance().shadowImage = appearance.shadowImage
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            
        } else {
            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
            UINavigationBar.appearance().shadowImage = UIImage()
        }
    
    }
    
    
    /*
     let app = UINavigationBarAppearance()
     app.configureWithOpaque()
     app.backgroundColor = UIColor.red
     navigationBar.standardAppearance = app
     navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
     */
    func setFontTypeUINavigationController() {
        
        if #available(iOS 15, *) {
            
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            //        appearance.backgroundColor = .white
            appearance.backgroundColor = .white //"202124".color
            appearance.titleTextAttributes = [.font: UIFont(name: "JFFlat-Regular", size: 12)!,
                                              .foregroundColor: "202124".color]
            
            UINavigationBar.appearance().tintColor = .black
            UINavigationBar.appearance().backgroundColor = .white
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            
        } else {
            
            let attrs = [
                NSAttributedString.Key.foregroundColor: "202124".color,
                NSAttributedString.Key.font: UIFont(name: "JFFlat-Regular", size: 12)!
            ]
            
            UINavigationBar.appearance().titleTextAttributes = attrs
        }
    }
    
    
    
    func removeTabBarTopLine() {
        if #available(iOS 15.0, *) {
            
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.shadowImage = UIImage()
//            appearance.backgroundImage = UIImage()
            
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = UITabBar().standardAppearance
            
        }else {
            UITabBar.appearance().shadowImage = UIImage()
            UITabBar.appearance().backgroundImage = UIImage()
        }
       
    }
    
    func setImageForBackArrow() {
        
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)
        let backArrowImage = UIImage(named: "img-arrow-English")?.withAlignmentRectInsets(insets)
        UINavigationBar.appearance().backIndicatorImage = backArrowImage
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backArrowImage
        
    }
    
    
    
    func presentLoginViewController(animated:Bool) {
        
        let controller = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "startNav")
        
        if animated {
            let options: UIView.AnimationOptions = [.transitionCrossDissolve, .curveEaseOut]
            
            UIView.transition(with: self.window!, duration: 0.4, options: options, animations: {
                self.window?.rootViewController = controller
            }, completion: nil)
            
        } else {
            self.window?.rootViewController = controller
        }
    }
    
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


    
   
    
}

