//
//  ViewController.swift
//  DVAppServices
//
//  Created by Nam Vu on 11/13/17.
//  Copyright © 2017 Nam DV. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickFetch(_ sender: Any) {
        let controller = ContactsViewController()
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    @IBAction func onClickOpen(_ sender: Any) {
        let controller = OpenContactViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}

