//
//  LoadingFooterView.swift
//  Yelp
//
//  Created by Felix Liman on 27/01/22.
//

import Foundation
import UIKit
import Kingfisher

final class LoadingFooterView: UICollectionReusableView {

    lazy var spinnerView = UIActivityIndicatorView().parent(view: self)

    static let identifier = "loadingFooterViewIdentifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear

        setupConstraints()
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        spinnerView.style {
            $0.color = .shade
            $0.startAnimating()
        }
    }

    private func setupConstraints() {
        spinnerView.snp.makeConstraints { make in
            make.center.equalTo(self)
        }

        setNeedsLayout()
        layoutIfNeeded()
    }

}
