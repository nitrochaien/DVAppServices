//
//  FacebookServicesViewController.swift
//  DVAppServices
//
//  Created by Nam Dinh Vu on 11/18/17.
//  Copyright © 2017 Nam DV. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore

class FacebookServicesViewController: BaseViewController {

    var isCustomButton = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let accessToken = AccessToken.current {
            print("Access token's app ID: " + accessToken.appId)
        } else {
            print("Not loggedIn")
        }
        
        if isCustomButton {
            addCustomButton()
        } else {
            addDefaultButton()
        }
        
    }
    
    func addDefaultButton() {
        let loginButton = LoginButton(readPermissions: [.publicProfile])
        loginButton.frame = CGRect(x: 0, y: 0, width: loginButton.frame.size.width, height: loginButton.frame.size.height)
        
        view.addSubview(loginButton)
    }
    
    func addCustomButton() {
        let myLoginButton = UIButton(type: .custom)
        myLoginButton.backgroundColor = .darkGray
        myLoginButton.frame = CGRect(x: 0, y: 0, width: 180, height: 40)
        myLoginButton.center = view.center;
        myLoginButton.setTitle("My Login Button", for: .normal)
        
        // Handle clicks on the button
        myLoginButton.addTarget(self, action: #selector(onClickCustomButton), for: .touchUpInside)
        
        // Add the button to the view
        view.addSubview(myLoginButton)
    }
    
    @objc func onClickCustomButton() {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile], viewController: self) { loginResult in
            switch loginResult {
                case .failed(let err):
                    print(err)
                case .cancelled:
                    print("User cancelled login")
            case .success(_,  _, _):
                    print("Logged in!")
            }
        }
    }
}
