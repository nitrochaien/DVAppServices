//
//  SocialViewController.swift
//  DVAppServices
//
//  Created by Nam Vu on 11/28/17.
//  Copyright © 2017 Nam DV. All rights reserved.
//

import UIKit
import Social

class SocialViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addShareItem()
    }
    
    func addShareItem() {
        let shareItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(onShare))
        navigationItem.rightBarButtonItem = shareItem
    }
    
    @objc func onShare(_ item: UIBarButtonItem) {
        let actionSheet = UIAlertController(title: "Share", message: "Choose a sharing type", preferredStyle: .actionSheet)
        let shareFacebookItem = UIAlertAction(title: "Facebook", style: .default) { (action) in
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) {
                if let composeVC = SLComposeViewController(forServiceType: SLServiceTypeFacebook) {
                    composeVC.setInitialText("Share something...")
                    self.present(composeVC, animated: true, completion: nil)
                }
            } else {
                print("Not logged in Facebook")
            }
        }
        let shareTwitterItem = UIAlertAction(title: "Twitter", style: .default) { (action) in
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
                if let composeVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter) {
                    composeVC.setInitialText("Share something...")
                    self.present(composeVC, animated: true, completion: nil)
                }
            } else {
                print("Not logged in Twitter")
            }
        }
        let shareMoreItem = UIAlertAction(title: "...", style: .default) { (action) in
            let moreVC = UIActivityViewController(activityItems: ["sharing elements"], applicationActivities: nil)
            moreVC.excludedActivityTypes = [.mail, .postToFacebook, .postToTwitter]
            self.present(moreVC, animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheet.addAction(shareFacebookItem)
        actionSheet.addAction(shareTwitterItem)
        actionSheet.addAction(shareMoreItem)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)
    }
}
