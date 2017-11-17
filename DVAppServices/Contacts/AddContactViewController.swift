//
//  AddContactViewController.swift
//  DVAppServices
//
//  Created by Nam Vu on 11/13/17.
//  Copyright © 2017 Nam DV. All rights reserved.
//

import UIKit

protocol AddContactProtocol {
    func onCreatedNewContact(_ record: ContactEntry)
}

class AddContactViewController: BaseViewController {
    
    var textfieldFirstName: UITextField!
    var textfieldLastName: UITextField!
    var textfieldPhoneNums: UITextField!
    var textfieldEmail: UITextField!
    
    var delegate: AddContactProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textfieldFirstName = UITextField()
        textfieldFirstName.translatesAutoresizingMaskIntoConstraints = false
        textfieldFirstName.placeholder = "First Name"
        textfieldFirstName.borderStyle = .roundedRect
        textfieldFirstName.layer.borderColor = UIColor.blue.cgColor
        
        textfieldLastName = UITextField()
        textfieldLastName.translatesAutoresizingMaskIntoConstraints = false
        textfieldLastName.placeholder = "Last Name"
        textfieldLastName.borderStyle = .roundedRect
        textfieldLastName.layer.borderColor = UIColor.blue.cgColor
        
        textfieldPhoneNums = UITextField()
        textfieldPhoneNums.translatesAutoresizingMaskIntoConstraints = false
        textfieldPhoneNums.placeholder = "Phone Numbers"
        textfieldPhoneNums.borderStyle = .roundedRect
        textfieldPhoneNums.layer.borderColor = UIColor.blue.cgColor
        
        textfieldEmail = UITextField()
        textfieldEmail.translatesAutoresizingMaskIntoConstraints = false
        textfieldEmail.placeholder = "Email"
        textfieldEmail.borderStyle = .roundedRect
        textfieldEmail.layer.borderColor = UIColor.blue.cgColor
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(onSave), for: .touchUpInside)
        
        view.addSubview(textfieldFirstName)
        view.addSubview(textfieldLastName)
        view.addSubview(textfieldPhoneNums)
        view.addSubview(textfieldEmail)
        view.addSubview(button)
        
        let dict = ["tf1" : textfieldFirstName,
                    "tf2" : textfieldLastName,
                    "tf3" : textfieldPhoneNums,
                    "tf4" : textfieldEmail,
                    "btn" : button] as [String : Any]
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[tf1]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[tf2]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[tf3]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[tf4]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[btn]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[tf1]-[tf2]-[tf3]-[tf4]-[btn]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict))
    }
    
    @objc func onSave(_ sender: UIButton) {
        guard let text = textfieldFirstName.text else { return }
        if text.isEmpty { return }
        
        let email = textfieldEmail.text
        let phone = textfieldPhoneNums.text
        let entry = ContactEntry(name: text, email: email, phone: phone, image: nil)
        
        delegate?.onCreatedNewContact(entry)
        navigationController?.popViewController(animated: true)
    }
}
