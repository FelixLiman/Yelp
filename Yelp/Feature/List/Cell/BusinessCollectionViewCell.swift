//
//  BusinessCollectionViewCell.swift
//  Yelp
//
//  Created by Felix Liman on 26/01/22.
//

import UIKit
import SnapKit
import Kingfisher

class BusinessCollectionViewCell: UICollectionViewCell {
    lazy var photoImg = UIImageView().parent(view: contentView)
    lazy var nameLbl = UILabel().parent(view: contentView)
    lazy var ratingLbl = UILabel().parent(view: contentView)
    lazy var dotLbl = UILabel().parent(view: contentView)
    lazy var priceLbl = UILabel().parent(view: contentView)

    static let identifier = "BusinessCollectionViewCellIdentifier"

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(contentView)

        setupConstraints()
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setData(business: BusinessCellViewModel?) {
        photoImg.setImage(string: business?.business.imageUrl)
        nameLbl.text = business?.business.name?.uppercased()
        ratingLbl.text = "⭐️ \(business?.business.rating ?? 0) (\(business?.business.reviewCount ?? 0) reviews)".uppercased()
        dotLbl.text = "·".uppercased()
        priceLbl.text = business?.business.price?.uppercased()
    }

    private func setupViews() {
        photoImg.style {
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
        }

        nameLbl.style {
            $0.textColor = .shade
            $0.font = .systemFont(ofSize: 16)
            $0.numberOfLines = 2
        }

        ratingLbl.style {
            $0.textColor = .shade
            $0.font = .systemFont(ofSize: 14)
            $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        }

        dotLbl.style {
            $0.textColor = .shade
            $0.font = .systemFont(ofSize: 14)
            $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        }

        priceLbl.style {
            $0.textColor = .shade
            $0.font = .systemFont(ofSize: 14)
            $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        }
    }

    private func setupConstraints() {
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        photoImg.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.size.equalTo(80)
        }

        nameLbl.snp.makeConstraints { make in
            make.top.equalTo(photoImg)
            make.leading.equalTo(photoImg.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        ratingLbl.snp.makeConstraints { make in
            make.top.equalTo(nameLbl.snp.bottom)
            make.leading.equalTo(photoImg.snp.trailing).offset(16)
        }

        dotLbl.snp.makeConstraints { make in
            make.top.equalTo(nameLbl.snp.bottom)
            make.leading.equalTo(ratingLbl.snp.trailing).offset(4)
        }

        priceLbl.snp.makeConstraints { make in
            make.top.equalTo(nameLbl.snp.bottom)
            make.leading.equalTo(dotLbl.snp.trailing).offset(4)
        }

        setNeedsLayout()
        layoutIfNeeded()
    }
}
