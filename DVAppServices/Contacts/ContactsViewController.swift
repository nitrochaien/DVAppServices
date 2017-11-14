//
//  ContactsViewController.swift
//  DVAppServices
//
//  Created by Nam Vu on 11/13/17.
//  Copyright © 2017 Nam DV. All rights reserved.
//

import UIKit
import Contacts

class ContactsViewController: BaseViewController, AddContactProtocol {
    
    var tableView: UITableView!
    var labelLoading: UILabel!
    
    var contactStore = CNContactStore()
    var contacts = [ContactEntry]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addCreateContactIcon()
        addTableView()
        addLabelLoading()
        
        showHideLoading(false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        requestAccessContacts { (success) in
            if success {
                self.fetchContacts({ (fetchSuccess, cnContacts) in
                    self.showHideLoading(fetchSuccess)
                    guard let contacts = cnContacts else {
                        self.labelLoading.text = "Unable to get contacts..."
                        return
                    }
                    self.contacts = contacts
                    self.tableView.reloadData()
                })
            }
        }
    }
    
    fileprivate func addCreateContactIcon() {
        let createContactButton = UIBarButtonItem(barButtonSystemItem: .add
            , target: self, action: #selector(addContact))
        navigationItem.rightBarButtonItem = createContactButton
    }
    
    @objc fileprivate func addContact(_ sender: UIBarButtonItem) {
        let controller = AddContactViewController()
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
    
    fileprivate func addTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
    
    fileprivate func addLabelLoading() {
        labelLoading = UILabel()
        labelLoading.text = "Fetching data..."
        labelLoading.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(labelLoading)
        
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: labelLoading, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: labelLoading, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    fileprivate func showHideLoading(_ contactAvailable: Bool) {
        tableView.isHidden = !contactAvailable
        labelLoading.isHidden = contactAvailable
    }
    
    fileprivate func requestAccessContacts(_ completion: @escaping (_ success: Bool) -> ()) {
        let authStatus = CNContactStore.authorizationStatus(for: .contacts)
        
        switch authStatus {
        case .authorized:
            completion(true)
        case .denied, .notDetermined:
            self.contactStore.requestAccess(for: .contacts, completionHandler: { (accessGranted, err) in
                completion(accessGranted)
            })
        default:
            completion(false)
        }
    }
    
    fileprivate func fetchContacts(_ completion: (_ success: Bool, _ contacts: [ContactEntry]?) -> ()) {
        var contacts = [ContactEntry]()
        do {
            let request = CNContactFetchRequest(keysToFetch: [CNContactGivenNameKey as CNKeyDescriptor, CNContactFamilyNameKey as CNKeyDescriptor, CNContactImageDataKey as CNKeyDescriptor, CNContactImageDataAvailableKey as CNKeyDescriptor, CNContactPhoneNumbersKey as CNKeyDescriptor, CNContactEmailAddressesKey as CNKeyDescriptor])
            try contactStore.enumerateContacts(with: request, usingBlock: { (cnContact, err) in
                if let contact = ContactEntry(cnContact) {
                    contacts.append(contact)
                }
            })
            completion(true, contacts)
        } catch {
            completion(false, nil)
        }
    }
    
    func onCreatedNewContact(_ record: ContactEntry) {
        let newContact = CNMutableContact()
        newContact.givenName = record.name
        
        if let email = record.email {
            let contactEmail = CNLabeledValue(label: CNLabelHome, value: email as NSString)
            newContact.emailAddresses = [contactEmail]
        }
        
        if let phone = record.phone {
            let contactPhone = CNLabeledValue(label: CNLabelHome, value: CNPhoneNumber(stringValue: phone))
            newContact.phoneNumbers = [contactPhone]
        }
        
        if let image = record.image {
            newContact.imageData = UIImageJPEGRepresentation(image, 0.9)
        }
        
        do {
            let request = CNSaveRequest()
            request.add(newContact, toContainerWithIdentifier: nil)
            try CNContactStore().execute(request)
        } catch {
            print("Unable to create contact!")
        }
    }
}

extension ContactsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        let entry = contacts[indexPath.row]
        cell.textLabel?.text = entry.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
}
