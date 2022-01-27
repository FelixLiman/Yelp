//
//  DetailViewModel.swift
//  Yelp
//
//  Created by Felix Liman on 27/01/22.
//

import Foundation
import Alamofire

final class DetailViewModel {
    var stateDidUpdate: ((ViewModelState) -> Void)?
    private(set) var id: String
    private(set) var business: Business?
    var bannerCellViewModels = [BannerCellViewModel]()
    var hourCellViewModels = [BusinessHourCellViewModel]()

    init(id: String) {
        self.id = id
    }

    func getBusinessDetail() {
        let session = Session.default
        let router = APIAction.getBusinessDetail(id: id)
        NetworkManager(session: session, router: router)
            .request(type: Business.self) { [weak self] model in
                self?.business = model
                model.photos?.forEach { photo in
                    let cellViewModel = BannerCellViewModel(photo: photo)
                    self?.bannerCellViewModels.append(cellViewModel)
                }
                model.hours?.first?.open?.forEach { businessHour in
                    let cellViewModel = BusinessHourCellViewModel(businessHour: businessHour)
                    self?.hourCellViewModels.append(cellViewModel)
                }
                self?.stateDidUpdate?(.finish)
            } failed: { [weak self] error in
                self?.stateDidUpdate?(.error(error))
            }
    }
}
