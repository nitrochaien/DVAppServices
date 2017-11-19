//
//  GoogleServicesViewController.swift
//  DVAppServices
//
//  Created by Nam Dinh Vu on 11/19/17.
//  Copyright © 2017 Nam DV. All rights reserved.
//

import UIKit

class GoogleServicesViewController: BaseViewController, GIDSignInUIDelegate {
    
    var buttonSignIn: GIDSignInButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance().uiDelegate = self
        
        buttonSignIn = GIDSignInButton()
        buttonSignIn.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        buttonSignIn.colorScheme = .dark
        buttonSignIn.style = .standard
        buttonSignIn.addTarget(self, action: #selector(onClickSignIn), for: .touchUpInside)
        
        view.addSubview(buttonSignIn)
    }
    
    @objc func onClickSignIn(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    //MARK: Sign In Delegate
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        //Handle event
    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        dismiss(animated: true, completion: nil)
    }
}
