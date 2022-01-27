//
//  DetailViewController.swift
//  Yelp
//
//  Created by Felix Liman on 27/01/22.
//

import UIKit

final class DetailViewController: UIViewController {

    private var id: String!
    private var viewModel: DetailViewModel!
    lazy var root = DetailView()

    init(id: String) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view = root

        root.photosCollectionView.delegate = self
        root.photosCollectionView.dataSource = self

        root.hoursCollectionView.delegate = self
        root.hoursCollectionView.dataSource = self

        setupViewModel()
    }

    private func setupViewModel() {
        viewModel = DetailViewModel(id: id)
        viewModel.stateDidUpdate = { [weak self] state in
            switch state {
            case .loading:
                break
            case .finish:
                guard let business = self?.viewModel.business else { return }
                self?.root.setData(business: business)
                self?.root.photosCollectionView.reloadData()
                self?.root.hoursCollectionView.reloadData()
                self?.root.hoursCollectionView.automaticallyAdjustsContentSize()
            case .error(let error):
                let alert = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            }
        }
        viewModel.getBusinessDetail()
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return viewModel.business?.photos?.count ?? 0
        } else {
            return viewModel.business?.hours?.first?.open?.count ?? 0
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BannerCollectionViewCell.identifier,
                for: indexPath) as? BannerCollectionViewCell
            else { return UICollectionViewCell() }
            let cellViewModel = viewModel.bannerCellViewModels.get(indexPath.item)
            cell.setData(photo: cellViewModel)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BusinessHoursCollectionViewCell.identifier,
                for: indexPath) as? BusinessHoursCollectionViewCell
            else { return UICollectionViewCell() }
            let cellViewModel = viewModel.hourCellViewModels.get(indexPath.item)
            cell.setData(businessHour: cellViewModel)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1 {
            let size = CGSize(width: collectionView.frame.width, height: 200)
            return size
        } else {
            if let cell = collectionView.cellForItem(at: indexPath) as? BusinessHoursCollectionViewCell {
                let cellViewModel = viewModel.hourCellViewModels.get(indexPath.item)
                cell.setData(businessHour: cellViewModel)
                let size = CGSize(width: collectionView.frame.width, height: cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height)
                return size
            } else {
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: BusinessHoursCollectionViewCell.identifier,
                    for: indexPath) as? BusinessHoursCollectionViewCell
                else { return CGSize() }
                let cellViewModel = viewModel.hourCellViewModels.get(indexPath.item)
                cell.setData(businessHour: cellViewModel)
                let size = CGSize(width: collectionView.frame.width, height: cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height)
                return size
            }
        }
    }
}
