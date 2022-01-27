//
//  DetailView.swift
//  Yelp
//
//  Created by Felix Liman on 27/01/22.
//

import UIKit
import Kingfisher

final class DetailView: UIView {

    lazy var scrollView = UIScrollView().parent(view: self)
    lazy var contentView = UIView().parent(view: scrollView)

    lazy var photosCollectionView = UICollectionView(frame: CGRect(), collectionViewLayout: UICollectionViewLayout()).parent(view: contentView)
    lazy var nameLbl = UILabel().parent(view: contentView)
    lazy var ratingLbl = UILabel().parent(view: contentView)
    lazy var addressLbl = UILabel().parent(view: contentView)
    lazy var categoryLbl = UILabel().parent(view: contentView)
    lazy var phoneLbl = UILabel().parent(view: contentView)
    lazy var displayPhoneLbl = UILabel().parent(view: contentView)

    lazy var hoursLbl = UILabel().parent(view: contentView)
    lazy var hoursCollectionView = UICollectionView(frame: CGRect(), collectionViewLayout: UICollectionViewLayout()).parent(view: contentView)

    override init(frame: CGRect) {
        super.init(frame: mainScreen)
        backgroundColor = .tone

        setupConstraints()
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setData(business: Business) {
        nameLbl.text = "\(business.name?.uppercased() ?? "") · \(business.price?.uppercased() ?? "")"
        addressLbl.text = (business.location?.address1 ?? "").uppercased() + (business.location?.address2 ?? "").uppercased() + (business.location?.address3 ?? "").uppercased()
        ratingLbl.text = "⭐️ \(business.rating ?? 0.0) (\(business.reviewCount ?? 0))".uppercased()
        categoryLbl.text = business.categories?.map({ $0.title ?? "" }).joined(separator: ", ").uppercased()
        phoneLbl.text = "📞 \(business.phone ?? "")"
        displayPhoneLbl.text = "☎️ \(business.displayPhone ?? "")"
        hoursLbl.text = "Hours".uppercased()
    }

    private func setupViews() {
        photosCollectionView.style {
            $0.tag = 1
            $0.backgroundColor = .clear
            $0.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            layout.scrollDirection = .horizontal
            $0.setCollectionViewLayout(layout, animated: true)
            $0.isPagingEnabled = true
        }

        nameLbl.style {
            $0.numberOfLines = 0
            $0.font = .systemFont(ofSize: 16)
        }

        ratingLbl.style {
            $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            $0.numberOfLines = 0
            $0.font = .systemFont(ofSize: 14)
        }

        addressLbl.style {
            $0.numberOfLines = 0
            $0.font = .systemFont(ofSize: 14)
        }

        categoryLbl.style {
            $0.numberOfLines = 0
            $0.font = .systemFont(ofSize: 14)
        }

        phoneLbl.style {
            $0.numberOfLines = 0
            $0.font = .systemFont(ofSize: 14)
        }

        displayPhoneLbl.style {
            $0.numberOfLines = 0
            $0.font = .systemFont(ofSize: 14)
        }

        hoursLbl.style {
            $0.numberOfLines = 0
            $0.font = .systemFont(ofSize: 16)
        }

        hoursCollectionView.style {
            $0.tag = 2
            $0.backgroundColor = .clear
            $0.register(BusinessHoursCollectionViewCell.self, forCellWithReuseIdentifier: BusinessHoursCollectionViewCell.identifier)
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 12
            layout.minimumLineSpacing = 12
            layout.scrollDirection = .horizontal
            $0.setCollectionViewLayout(layout, animated: true)
            $0.isPagingEnabled = true
        }
    }

    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
        }

        photosCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }

        nameLbl.snp.makeConstraints { make in
            make.top.equalTo(photosCollectionView.snp.bottom).offset(16)
            make.leading.equalTo(photosCollectionView).offset(16)
            make.trailing.equalTo(ratingLbl.snp.leading).offset(-16)
        }

        ratingLbl.snp.makeConstraints { make in
            make.centerY.equalTo(nameLbl)
            make.leading.equalTo(nameLbl.snp.trailing).offset(16)
            make.trailing.equalTo(photosCollectionView).offset(-16)
        }

        addressLbl.snp.makeConstraints { make in
            make.top.equalTo(nameLbl.snp.bottom).offset(12)
            make.leading.equalTo(photosCollectionView).offset(16)
            make.trailing.equalTo(photosCollectionView).offset(-16)
        }

        categoryLbl.snp.makeConstraints { make in
            make.top.equalTo(addressLbl.snp.bottom).offset(16)
            make.leading.equalTo(photosCollectionView).offset(16)
            make.trailing.equalTo(photosCollectionView).offset(-16)
        }

        phoneLbl.snp.makeConstraints { make in
            make.top.equalTo(categoryLbl.snp.bottom).offset(16)
            make.leading.equalTo(photosCollectionView).offset(16)
            make.trailing.equalTo(photosCollectionView).offset(-16)
        }

        displayPhoneLbl.snp.makeConstraints { make in
            make.top.equalTo(phoneLbl.snp.bottom).offset(12)
            make.leading.equalTo(photosCollectionView).offset(16)
            make.trailing.equalTo(photosCollectionView).offset(-16)
        }

        hoursLbl.snp.makeConstraints { make in
            make.top.equalTo(displayPhoneLbl.snp.bottom).offset(16)
            make.leading.equalTo(photosCollectionView).offset(16)
            make.trailing.equalTo(photosCollectionView).offset(-16)
        }

        hoursCollectionView.snp.makeConstraints { make in
            make.top.equalTo(hoursLbl.snp.bottom).offset(16)
            make.leading.equalTo(photosCollectionView).offset(16)
            make.trailing.equalTo(photosCollectionView).offset(-16)
            make.bottom.equalTo(contentView).offset(-16)
            make.height.equalTo(0).priority(999)
        }
        
        layoutIfNeeded()
        setNeedsLayout()
    }
}
