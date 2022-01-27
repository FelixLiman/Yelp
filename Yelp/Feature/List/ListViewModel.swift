//
//  ListViewModel.swift
//  Yelp
//
//  Created by Felix Liman on 26/01/22.
//

import Foundation
import Alamofire

enum BusinessSortBy: String {
    case bestMatch = "best_match"
    case rating = "rating"
    case reviewCount = "review_count"
    case distance = "distance"
}

enum ViewModelState {
    case loading
    case finish
    case error(AFError)
}

final class ListViewModel {
    var stateDidUpdate: ((ViewModelState) -> Void)?
    private(set) var businesses = [Business]()
    var cellViewModels = [BusinessCellViewModel]()
    var limit: Int = 10
    var offset: Int = 0
    var search: String?
    var hasData = true
    var sortBy: BusinessSortBy = .bestMatch
    var totalBusiness: Int {
        return businesses.count
    }

    func getBusinesses() {
        let session = Session.default
        let router = APIAction.getBusinesses(limit: limit, offset: offset, sortBy: sortBy.rawValue, term: search)
        NetworkManager(session: session, router: router)
            .request(type: BusinessModel.self) { [weak self] model in
                self?.businesses.append(contentsOf: model.businesses)
                model.businesses.forEach { business in
                    let cellViewModel = BusinessCellViewModel(business: business)
                    self?.cellViewModels.append(cellViewModel)
                }
                self?.stateDidUpdate?(.finish)
            } failed: { [weak self] error in
                self?.stateDidUpdate?(.error(error))
            }
    }

    func resetCollectionView() {
        offset = 0
        hasData = true
        businesses = []
        cellViewModels = []
        getBusinesses()
    }

    func fetchNextPage() {
        offset += 10
        getBusinesses()
    }
}
