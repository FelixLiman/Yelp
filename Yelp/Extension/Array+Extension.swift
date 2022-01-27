//
//  Array+Extension.swift
//  Yelp
//
//  Created by Felix Liman on 27/01/22.
//

import Foundation

extension Array {
    func get(_ index: Int) -> Element? {
        return (0 <= index && index < count) ? self[index] : nil
    }
}
