//
//  UIImageView.swift
//  Yelp
//
//  Created by Felix Liman on 27/01/22.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(string: String?) {
        if let urlString = string, let url = URL(string: urlString) {
            let imageResource = ImageResource(downloadURL: url, cacheKey: nil)
            self.kf.setImage(with: imageResource)
        }
    }
}
