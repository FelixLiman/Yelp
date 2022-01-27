//
//  BusinessCellViewModel.swift
//  Yelp
//
//  Created by Felix Liman on 27/01/22.
//

import Foundation

final class BusinessCellViewModel {

    private(set) var business: Business
    private var isLoading = false

    init(business: Business) {
        self.business = business
    }
}
