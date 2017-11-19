//
//  GoogleServicesViewController.swift
//  DVAppServices
//
//  Created by Nam Dinh Vu on 11/19/17.
//  Copyright © 2017 Nam DV. All rights reserved.
//

import UIKit
import SafariServices

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
        
        let shareButton = UIButton()
        shareButton.frame = CGRect(x: 0, y: 60, width: 200, height: 30)
        shareButton.setTitle("Share on Google", for: .normal)
        shareButton.backgroundColor = UIColor.blue
        shareButton.setTitleColor(.white, for: .normal)
        shareButton.addTarget(self, action: #selector(onShare), for: .touchUpInside)
    }
    
    @objc func onClickSignIn(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    @objc func onShare(_ sender: UIButton) {
        //Share with Google+ Sign In is deprecated
        //Use basic sharing instead
        
        let sharedURL = "https://www.facebook.com"
        guard let url = URL(string: "https://plus.google.com/share") else { return }
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [URLQueryItem(name: "url", value: sharedURL)]
        if let url = urlComponents?.url {
            let sfController = SFSafariViewController(url: url)
            present(sfController, animated: true, completion: nil)
        }
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
