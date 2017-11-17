//
//  EventViewController.swift
//  DVAppServices
//
//  Created by Nam Vu on 11/16/17.
//  Copyright © 2017 Nam DV. All rights reserved.
//

import UIKit
import EventKit

class EventViewController: BaseViewController {
    
    //Example: https://www.andrewcbancroft.com/2016/06/02/creating-calendar-events-with-event-kit-and-swift/
    
    var textField: UITextField!
    var datePicker: UIDatePicker!
    var button: UIButton!
    
    var calendar = EKCalendar()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField = UITextField()
        textField.placeholder = "Event name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        datePicker = UIDatePicker()
        datePicker.calendar = Calendar(identifier: .gregorian)
        datePicker.datePickerMode = .dateAndTime
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add Event", for: .normal)
        button.addTarget(self, action: #selector(onCreateEvent), for: .touchUpInside)
        
        view.addSubview(textField)
        view.addSubview(datePicker)
        
        let dict = ["tf" : textField,
        "dp" : datePicker] as [String : Any]
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[tf]-[dp]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tf]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict))
    }
    
    @objc func onCreateEvent() {
        
    }
}
