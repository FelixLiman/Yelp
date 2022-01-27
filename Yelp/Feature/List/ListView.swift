//
//  ListView.swift
//  Yelp
//
//  Created by Felix Liman on 26/01/22.
//

import UIKit
import SnapKit

final class ListView: UIView {
    lazy var searchBar = UISearchBar().parent(view: self)
    lazy var sortBtn = UIButton().parent(view: self)
    lazy var businessCollection = UICollectionView(frame: CGRect(), collectionViewLayout: UICollectionViewLayout()).parent(view: self)

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .tone

        setupConstraints()
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        searchBar.style {
            $0.backgroundImage = UIImage()
            $0.searchTextField.backgroundColor = .tint
            $0.searchTextField.font = .systemFont(ofSize: 16)
            $0.searchTextField.tintColor = .shade
            $0.searchTextField.textColor = .shade
            $0.searchTextField.autocapitalizationType = .allCharacters
            $0.enablesReturnKeyAutomatically = false
            $0.placeholder = "Try \"rice\"".uppercased()
        }

        sortBtn.style {
            $0.backgroundColor = .tint
            $0.tintColor = .shade
            $0.setTitle("Sort".uppercased(), for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 16)
            $0.setTitleColor(.shade, for: .normal)
            $0.setLayer(cornerRadius: 8)
        }

        businessCollection.style {
            $0.backgroundColor = .clear
            $0.register(BusinessCollectionViewCell.self, forCellWithReuseIdentifier: BusinessCollectionViewCell.identifier)
            $0.register(LoadingFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: LoadingFooterView.identifier)
            let layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = 8
            layout.minimumInteritemSpacing = 8
            layout.scrollDirection = .vertical
            $0.setCollectionViewLayout(layout, animated: true)
        }
    }

    private func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(self).offset(60)
            make.leading.equalTo(self).offset(12)
        }

        sortBtn.snp.makeConstraints { make in
            make.centerY.equalTo(searchBar)
            make.leading.equalTo(searchBar.snp.trailing).offset(4)
            make.trailing.equalTo(self).offset(-12)
        }

        sortBtn.titleLabel?.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }

        businessCollection.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(6)
            make.leading.equalTo(self).offset(12)
            make.trailing.equalTo(self).offset(-12)
            make.bottom.equalTo(self).offset(-12)
        }

        setNeedsLayout()
        layoutIfNeeded()
    }
}
