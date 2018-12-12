//
//  AppDelegate.swift
//  MarvelApp
//
//  Created by Kaique Magno Dos Santos on 21/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit
import Reachability

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let reachability = Reachability()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.init(patternImage: #imageLiteral(resourceName: "BackgroundView"))
        
        let charactersRouter = CharactersRouter()
        let charactersNavigationRouter = NavigationRouter(rootViewController: charactersRouter.presenter.view)
        
        let charactersFavoritedRouter = CharactersFavoritedRouter()
        let charactersFavoritedNavigationRouter = NavigationRouter(rootViewController: charactersFavoritedRouter.presenter.view)
        
        let tabBarRouter = TabBarRouter(viewControllers: [charactersNavigationRouter.presenter.view,charactersFavoritedNavigationRouter.presenter.view])
        
        self.window?.rootViewController = tabBarRouter.presenter.view
        self.window?.makeKeyAndVisible()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try self.reachability?.startNotifier()
        }catch{
            Logger.logError(in: self, message: "could not start reachability notifier")
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.reachability?.stopNotifier()
    }

    // MARK: - Recheability
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
        case .cellular:
            print("Reachable via Cellular")
        case .none:
            AlertRouter.showAlert(with: "Please, connect to Internet", sender: nil)
        }
    }
}

