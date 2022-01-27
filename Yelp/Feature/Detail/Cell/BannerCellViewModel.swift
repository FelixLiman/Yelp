//
//  BannerCellViewModel.swift
//  Yelp
//
//  Created by Felix Liman on 27/01/22.
//

import Foundation

final class BannerCellViewModel {

    private(set) var photo: String
    private var isLoading = false

    init(photo: String) {
        self.photo = photo
    }
}
