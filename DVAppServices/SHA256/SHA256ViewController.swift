//
//  SHA256ViewController.swift
//  DVAppServices
//
//  Created by Nam Vu on 2/2/18.
//  Copyright © 2018 Nam DV. All rights reserved.
//

import UIKit

class SHA256ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let sample = "My name is Nam"
        print("SHA256 encryption of \(sample) is: \(sample.sha256())")
    }
}
