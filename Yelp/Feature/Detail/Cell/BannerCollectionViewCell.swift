//
//  BannerCollectionViewCell.swift
//  Yelp
//
//  Created by Felix Liman on 27/01/22.
//

import UIKit
import SnapKit
import Kingfisher

class BannerCollectionViewCell: UICollectionViewCell {
    lazy var photoImg = UIImageView().parent(view: contentView)

    static let identifier = "BannerCollectionViewCellIdentifier"

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(contentView)

        setupConstraints()
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setData(photo: BannerCellViewModel?) {
        if let urlString = photo?.photo, let url = URL(string: urlString) {
            let imageResource = ImageResource(downloadURL: url, cacheKey: nil)
            photoImg.kf.setImage(with: imageResource)
        }
    }

    private func setupViews() {
        photoImg.style {
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
        }
    }

    private func setupConstraints() {
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        photoImg.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        setNeedsLayout()
        layoutIfNeeded()
    }
}
