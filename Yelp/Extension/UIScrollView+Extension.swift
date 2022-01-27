//
//  UIScrollView+Extension.swift
//  Yelp
//
//  Created by Felix Liman on 27/01/22.
//

import UIKit
import Stevia

extension UIScrollView {

    func automaticallyAdjustsContentSize() {
        heightConstraint?.constant = CGFloat.greatestFiniteMagnitude
        layoutIfNeeded()
        heightConstraint?.constant = contentSize.height + contentInset.top + contentInset.bottom
    }

}
