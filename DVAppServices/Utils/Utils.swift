//
//  Utils.swift
//  DVAppServices
//
//  Created by Nam Vu on 11/13/17.
//  Copyright © 2017 Nam DV. All rights reserved.
//

import UIKit

extension String {
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]+$", options: NSRegularExpression.Options.caseInsensitive)
            return regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil
        } catch { return false }
    }
}
