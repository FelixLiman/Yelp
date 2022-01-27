//
//  UIAppearance+Extension.swift
//  Yelp
//
//  Created by Felix Liman on 26/01/22.
//

import UIKit

extension UIAppearance {

    public func style(_ completion: @escaping ((Self) -> Void)) {
        completion(self)
    }

}
