//
//  NewSceneDelegate.swift
//  TabBar_Practice
//
//  Created by 이영우 on 2021/01/16.
//

import UIKit

class NewSceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let tbC = UITabBarController()
        tbC.view.backgroundColor = .white
        
        self.window?.rootViewController = tbC
        
        let view01 = ViewController()
        let view02 = SecondViewController()
        let view03 = ThirdViewController()
        
        tbC.setViewControllers([view01, view02, view03], animated: false)
        
        view01.tabBarItem = UITabBarItem(title: "Calendar", image: UIImage(named: "calendar"), selectedImage: nil)
        view02.tabBarItem = UITabBarItem(title: "File", image: UIImage(named: "file-three"), selectedImage: nil)
        view03.tabBarItem = UITabBarItem(title: "photo", image: UIImage(named: "photo"), selectedImage: nil)
        
        return
    }
    
    
    
}
