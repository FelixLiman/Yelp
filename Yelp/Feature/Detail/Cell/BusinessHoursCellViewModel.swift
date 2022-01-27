//
//  BusinessHourCellViewModel.swift
//  Yelp
//
//  Created by Felix Liman on 27/01/22.
//

import Foundation

final class BusinessHourCellViewModel {

    private(set) var businessHour: BusinessCertainHour
    private var isLoading = false

    init(businessHour: BusinessCertainHour) {
        self.businessHour = businessHour
    }
}
