//
//  AppDelegate.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 06/08/25.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let rootViewController = TabBarViewController()
        let rootNavigationController = UINavigationController(rootViewController: rootViewController)
        rootNavigationController.navigationBar.prefersLargeTitles = true
        rootNavigationController.navigationItem.largeTitleDisplayMode = .always
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = rootNavigationController
        self.window?.makeKeyAndVisible()
        return true
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "CoreDatabase")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}

