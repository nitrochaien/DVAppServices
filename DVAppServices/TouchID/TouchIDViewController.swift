//
//  TouchIDViewController.swift
//  DVAppServices
//
//  Created by Nam Vu on 2/26/18.
//  Copyright © 2018 Nam DV. All rights reserved.
//

import UIKit
import LocalAuthentication

class TouchIDViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton()
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        button.setTitle("Touch ID", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(onAuthen), for: .touchUpInside)
        
        view.addSubview(button)
    }
    
    @objc func onAuthen() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Use Touch ID to unlock App"
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason, reply: { (success, err) in
                if success {
                    self.showAlertController("Passcode Authentication succeeded.")
                } else {
                    self.showAlertController("Passcode Authentication failed.")
                }
            })
        } else {
            self.showAlertController("Not available.")
        }
    }
    
    func showAlertController(_ message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
