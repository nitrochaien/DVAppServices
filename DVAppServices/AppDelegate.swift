//
//  AppDelegate.swift
//  DVAppServices
//
//  Created by Nam Vu on 11/13/17.
//  Copyright © 2017 Nam DV. All rights reserved.
//

import UIKit
import FacebookLogin

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        showContactsViewController()
        showFacebookServicesViewController()
//        showGoogleServicesViewController()
        self.window?.backgroundColor = .white
        
        return true
    }
    
    func showContactsViewController() {
        let navigation = UINavigationController()
        let controller = ContactsViewController()
        navigation.viewControllers = [controller]
        self.window?.rootViewController = navigation
        self.window?.makeKeyAndVisible()
    }
    
    func showFacebookServicesViewController() {
        let navigation = UINavigationController()
        let controller = FacebookServicesViewController()
        navigation.viewControllers = [controller]
        self.window?.rootViewController = navigation
        self.window?.makeKeyAndVisible()
    }
    
    func showGoogleServicesViewController() {
        let navigation = UINavigationController()
        let controller = GoogleServicesViewController()
        navigation.viewControllers = [controller]
        self.window?.rootViewController = navigation
        self.window?.makeKeyAndVisible()
        
        //configure Googler Services
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(String(describing: configureError))")
        
        GIDSignIn.sharedInstance().delegate = self
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
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        return GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }
    
    // MARK: Google SignIn delegate
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard error == nil else { return }
        
        let userID: String = user.userID
        let idToken: String = user.authentication.idToken
        let fullName: String = user.profile.name
        
        print("User id: ", userID, " id token", idToken, " fullName: ", fullName)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        //Handle sign in fail
    }
}

