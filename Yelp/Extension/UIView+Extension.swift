//
//  UIView+Extension.swift
//  Yelp
//
//  Created by Felix Liman on 26/01/22.
//

import UIKit

extension UIView {
    @discardableResult
    func parent(view: UIView) -> Self {
        if let stackView = view as? UIStackView {
            stackView.addArrangedSubview(self)
        } else {
            view.addSubview(self)
        }
        return self
    }
    
    public func setLayer(cornerRadius: CGFloat? = nil, borderWidth width: CGFloat? = nil, borderColor color: UIColor? = nil, withMasks masks: Bool = false) {
        setNeedsLayout()
        layoutIfNeeded()
        if let radius = cornerRadius {
            let size = (frame.width == 0 ? frame.height : frame.width) / 2
            layer.cornerRadius = (radius == 0 ? size : radius)
        } else {
            layer.cornerRadius = 0
        }

        if let width = width {
            layer.borderWidth = width
        }
        if let color = color {
            layer.borderColor = color.cgColor
        }
        layer.masksToBounds = masks
    }
}
