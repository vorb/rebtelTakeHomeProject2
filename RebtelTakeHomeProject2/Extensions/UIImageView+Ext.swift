//
//  UIImageView+Ext.swift
//  RebtelTakeHomeProject2
//
//  Created by Sebastian Mendez on 2021-09-14.
//

import UIKit

extension UIImageView {
    func makeRounded() {
        self.layer.cornerRadius = (self.frame.width / 2)
        self.layer.masksToBounds = true
    }
}
