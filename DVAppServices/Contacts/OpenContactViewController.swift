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
    
    var buttonSingleContact: UIButton!
    var buttonMultipleContacts: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonSingleContact = UIButton()
        buttonSingleContact.backgroundColor = .green
        buttonSingleContact.setTitle("Open Contact", for: .normal)
        buttonSingleContact.translatesAutoresizingMaskIntoConstraints = false
        buttonSingleContact.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        
        view.addSubview(buttonSingleContact)
        
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: buttonSingleContact, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: buttonSingleContact, attribute: .centerY, multiplier: 1, constant: 0))
        
        buttonMultipleContacts = UIButton()
        buttonMultipleContacts.backgroundColor = .green
        buttonMultipleContacts.setTitle("Open Contacts", for: .normal)
        buttonMultipleContacts.translatesAutoresizingMaskIntoConstraints = false
        buttonMultipleContacts.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        
        view.addSubview(buttonMultipleContacts)
        
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: buttonMultipleContacts, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: buttonMultipleContacts, attribute: .top, multiplier: 1, constant: -24))
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
    
    @objc func onClick(_ sender: UIButton) {
        let contactController = CNContactPickerViewController()
        contactController.delegate = self
        if sender == buttonSingleContact {
            //Do nothing
        }
        else if sender == buttonMultipleContacts {
            contactController.predicateForEnablingContact = NSPredicate(format: "emailAddresses.@count > 0")
        }
        present(contactController, animated: true, completion: nil)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        print("Selected contact named: ", contact.givenName)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
        for contact in contacts {
            print("Selected contact named: ", contact.givenName)
        }
    }
}
