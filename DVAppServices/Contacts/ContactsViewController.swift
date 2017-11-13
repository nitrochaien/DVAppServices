//
//  ContactsViewController.swift
//  DVAppServices
//
//  Created by Nam Vu on 11/13/17.
//  Copyright © 2017 Nam DV. All rights reserved.
//

import UIKit
import Contacts

class ContactsViewController: UIViewController {
    
    var tableView: UITableView!
    var labelLoading: UILabel!
    
    var contactStore = CNContactStore()
    var contacts = [ContactEntry]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addTableView()
        addLabelLoading()
        
        showHideLoading(false)
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
