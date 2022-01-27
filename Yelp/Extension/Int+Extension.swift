//
//  Int+Extension.swift
//  Yelp
//
//  Created by Felix Liman on 27/01/22.
//

import Foundation

extension Int {
    func convertToDayOfWeek() -> String {
        switch (self % 7) {
        case 0:
            return "Sunday"
        case 1:
            return "Monday"
        case 2:
            return "Tuesday"
        case 3:
            return "Wednesday"
        case 4:
            return "Thursday"
        case 5:
            return "Friday"
        case 6:
            return "Saturday"
        default:
            return ""
        }
    }
}
