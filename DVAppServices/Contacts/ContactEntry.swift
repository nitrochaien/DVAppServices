//
//  ContactEntry.swift
//  DVAppServices
//
//  Created by Nam Vu on 11/13/17.
//  Copyright © 2017 Nam DV. All rights reserved.
//

import UIKit
import Contacts

class ContactEntry: NSObject {
    var name: String!
    var email: String?
    var phone: String?
    var image: UIImage?
    
    init(name: String, email: String?, phone: String?, image: UIImage?) {
        self.name = name
        self.email = email
        self.phone = phone
        self.image = image
    }
    
    init?(_ cnContact: CNContact) {
        if !cnContact.isKeyAvailable(CNContactGivenNameKey)
            && !cnContact.isKeyAvailable(CNContactFamilyNameKey) { return nil }
        let nameString = cnContact.givenName + " " + cnContact.familyName
        self.name = nameString.trimmingCharacters(in: .whitespaces)
        
        self.image = (cnContact.isKeyAvailable(CNContactImageDataKey) && cnContact.imageDataAvailable) ? UIImage(data: cnContact.imageData!) : nil
        
        if cnContact.isKeyAvailable(CNContactEmailAddressesKey) {
            for email in cnContact.emailAddresses {
                let emailString = email.value as String
                if emailString.isEmail {
                    self.email = emailString
                    break
                }
            }
        }
        
        if cnContact.isKeyAvailable(CNContactPhoneNumbersKey) {
            if cnContact.phoneNumbers.count > 0 {
                let phone = cnContact.phoneNumbers.first?.value
                self.phone = phone?.stringValue
            }
        }
    }
}
