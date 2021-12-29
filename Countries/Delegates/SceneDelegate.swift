//
//  SceneDelegate.swift
//  Countries
//
//  Created by Khrystyna Matasova on 19.11.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let masterController = ListViewController(networkManager: NetworkManager())
        let masterNavigationController = UINavigationController(rootViewController: masterController)
        UINavigationBar.appearance().isTranslucent = false
        
        let detailController = DetailsViewController()
        let detailNavigationController = UINavigationController(rootViewController: detailController)
        
        let splitViewController = UISplitViewController()
        splitViewController.viewControllers = [masterNavigationController, detailNavigationController]
        splitViewController.delegate = self
        
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = splitViewController
        self.window?.makeKeyAndVisible()
    }
}

extension SceneDelegate: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}
