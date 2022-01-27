//
//  String+Extension.swift
//  Yelp
//
//  Created by Felix Liman on 27/01/22.
//

import Foundation

extension String {
    mutating func insert(string:String, ind:Int) {
        self.insert(contentsOf: string, at:self.index(self.startIndex, offsetBy: ind) )
    }
}
