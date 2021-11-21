//
//  CustomTabBar.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 9/29/21.
//

import UIKit

class CustomTabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
//            appearance.tint
//            appearance.shadowImage
            
            appearance.shadowColor = UIColor.black.withAlphaComponent(0.3)
//            appearance
            
            
            appearance.shadowImage = UIImage()
            appearance.backgroundImage = UIImage()
            
//            UITabBar.appearance().standardAppearance = appearance
//            UITabBar.appearance().scrollEdgeAppearance = UITabBar().standardAppearance
//            
            
            
            self.tabBar.standardAppearance = appearance
            self.tabBar.scrollEdgeAppearance = tabBar.standardAppearance
            
        }else {
            
            self.tabBar.barTintColor = .white
            self.tabBar.isTranslucent = false
            self.tabBar.shadowOffset = CGSize(width: 0, height: 0)
            self.tabBar.shadowColor = UIColor.black.withAlphaComponent(0.3)
            self.tabBar.shadowOpacity = 0.3
        }
        
        
    }
     
}
