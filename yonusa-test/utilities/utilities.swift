//
//  utilities.swift
//  yonusa-test
//
//  Created by Carlos Ponce on 22/07/20.
//  Copyright © 2020 Carlos Ponce. All rights reserved.
//

import Foundation
import UIKit
import Nuke

extension UIImageView {
    func loadImage(_ image: String) {
        if let urlSafe = image.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let url = URL(string: urlSafe) {
                Nuke.loadImage(with: url, into: self)
            }
        }
    }
}

