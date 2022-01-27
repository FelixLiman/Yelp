//
//  ListViewController.swift
//  Yelp
//
//  Created by Felix Liman on 26/01/22.
//

import UIKit
import Alamofire

class ListViewController: UIViewController {

    private var viewModel: ListViewModel!
    lazy var root = ListView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view = root

        root.businessCollection.delegate = self
        root.businessCollection.dataSource = self

        root.searchBar.delegate = self

        setupViewModel()
        setupButton()
    }

    private func setupViewModel() {
        viewModel = ListViewModel()
        viewModel.stateDidUpdate = { [weak self] state in
            switch state {
            case .loading:
                print("this is good")
                self?.root.businessCollection.isUserInteractionEnabled = false
            case .finish:
                self?.root.businessCollection.isUserInteractionEnabled = true
                self?.root.businessCollection.reloadData()
            case .error(let error):
                self?.root.businessCollection.isUserInteractionEnabled = true
                let alert = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            }
        }
        viewModel.getBusinesses()
    }

    @objc func sortBtnTapped() {
        let alertVC = UIAlertController(title: "Select Sort By", message: "Please select what variable to sort by", preferredStyle: .actionSheet)
        alertVC.addAction(UIAlertAction(title: "Best Match (Default)".uppercased(), style: .default, handler: { [weak self] _ in
            self?.viewModel.sortBy = .bestMatch
            self?.viewModel.resetCollectionView()
            self?.root.businessCollection.reloadData()
        }))
        alertVC.addAction(UIAlertAction(title: "Rating".uppercased(), style: .default, handler: { [weak self] _ in
            self?.viewModel.sortBy = .rating
            self?.viewModel.resetCollectionView()
            self?.root.businessCollection.reloadData()
        }))
        alertVC.addAction(UIAlertAction(title: "Review Count".uppercased(), style: .default, handler: { [weak self] _ in
            self?.viewModel.sortBy = .reviewCount
            self?.viewModel.resetCollectionView()
            self?.root.businessCollection.reloadData()
        }))
        alertVC.addAction(UIAlertAction(title: "Distance".uppercased(), style: .default, handler: { [weak self] _ in
            self?.viewModel.sortBy = .distance
            self?.viewModel.resetCollectionView()
            self?.root.businessCollection.reloadData()
        }))

        present(alertVC, animated: true, completion: nil)
    }

    private func setupButton() {
        root.sortBtn.addTarget(self, action: #selector(sortBtnTapped), for: .touchUpInside)
    }
}

extension ListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.totalBusiness
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BusinessCollectionViewCell.identifier,
            for: indexPath) as? BusinessCollectionViewCell
        else { return UICollectionViewCell()}
        let cellViewModel = viewModel.cellViewModels.get(indexPath.item)
        cell.setData(business: cellViewModel)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BusinessCollectionViewCell.identifier,
            for: indexPath) as? BusinessCollectionViewCell
        else { return CGSize() }
        let cellViewModel = viewModel.cellViewModels.get(indexPath.item)
        cell.setData(business: cellViewModel)
        let size = CGSize(width: collectionView.frame.width, height: cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height)
        return size
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let business = viewModel.businesses.get(indexPath.item) else { return }
        let detailVC = DetailViewController(id: business.id)
        navigationController?.pushViewController(detailVC, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let footer = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: LoadingFooterView.identifier,
            for: indexPath) as? LoadingFooterView
        else { return UICollectionReusableView() }
        return footer
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let width = collectionView.bounds.width
        var height: Double {
            if !viewModel.hasData {
                return 0.0
            }
            return viewModel.totalBusiness == 0 ? mainScreen.height * 0.8 : 50.0
        }
        let size = CGSize(width: width, height: height)
        return size
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let totalBusiness = self?.viewModel.totalBusiness, let hasData = self?.viewModel.hasData else { return }
            if collectionView.contentOffset.y > 0, indexPath.item == totalBusiness - 1, hasData, collectionView.visibleCells.contains(cell) {
                self?.viewModel.fetchNextPage()
            }
        }
    }
}

extension ListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.search = searchBar.text
        viewModel.resetCollectionView()
        root.businessCollection.reloadData()
        view.endEditing(true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.search = nil
        root.businessCollection.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        viewModel.resetCollectionView()
        root.businessCollection.reloadData()
    }
}
