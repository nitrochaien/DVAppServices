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
import FacebookShare

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
        
        addButtonShare()
    }
    
    func addDefaultButton() {
        let loginButton = LoginButton(readPermissions: [.publicProfile])
        loginButton.frame = CGRect(x: 0, y: 0, width: loginButton.frame.size.width, height: loginButton.frame.size.height)
        
        view.addSubview(loginButton)
    }
    
    func addButtonShare() {
        let shareButton = UIButton()
        shareButton.frame = CGRect(x: 0, y: 50, width: 200, height: 30)
        shareButton.setTitle("Share on Facebook", for: .normal)
        shareButton.backgroundColor = UIColor.blue
        shareButton.setTitleColor(.white, for: .normal)
        shareButton.addTarget(self, action: #selector(onShare), for: .touchUpInside)
        
        view.addSubview(shareButton)
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
    
    @objc func onShare(_ sender: UIButton) {
        guard let url = URL(string: "https://www.facebook.com") else { return }
        let content = LinkShareContent(url: url, quote: "Sample share")
        
        //write post
        let shareDialog = ShareDialog(content: content)
        shareDialog.mode = .automatic
//        shareDialog.mode = .native
        shareDialog.failsOnInvalidData = true
        shareDialog.completion = { result in
            print("Results: ", result)
        }
        
        //share in messenger
        let messageDialog = MessageDialog(content: content)

        do {
//            try shareDialog.show()
            try messageDialog.show()
        } catch let err {
            print("Err: ", err)
        }
    }
}
