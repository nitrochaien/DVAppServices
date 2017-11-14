//
//  OpenContactViewController.swift
//  DVAppServices
//
//  Created by Nam Vu on 11/14/17.
//  Copyright © 2017 Nam DV. All rights reserved.
//

import UIKit
import ContactsUI

class OpenContactViewController: BaseViewController, CNContactPickerDelegate {
    
    let contactStore = CNContactStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton()
        button.backgroundColor = .green
        button.setTitle("Open Contacts", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        
        view.addSubview(button)
        
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: button, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: button, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    func askPermission() {
        let status = CNContactStore.authorizationStatus(for: .contacts)
        switch status {
        case .authorized:
            break
        case .denied, .notDetermined:
            contactStore.requestAccess(for: .contacts, completionHandler: { (success, err) in
                if !success {
                    print("Oh no!")
                }
            })
        default:
            break
        }
    }
    
    @objc func onClick() {
        let contactController = CNContactPickerViewController()
        contactController.delegate = self
        present(contactController, animated: true, completion: nil)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        print("Selected contact named: ", contact.givenName)
    }
}
