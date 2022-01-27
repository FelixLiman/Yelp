//
//  BusinessHoursCollectionViewCell.swift
//  Yelp
//
//  Created by Felix Liman on 27/01/22.
//

import UIKit
import SnapKit

class BusinessHoursCollectionViewCell: UICollectionViewCell {
    lazy var dayLbl = UILabel().parent(view: contentView)
    lazy var startLbl = UILabel().parent(view: contentView)
    lazy var hyphenLbl = UILabel().parent(view: contentView)
    lazy var endLbl = UILabel().parent(view: contentView)

    static let identifier = "BusinessHoursCollectionViewCellIdentifier"

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(contentView)

        setupConstraints()
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setData(businessHour: BusinessHourCellViewModel?) {
        var day = ""
        switch businessHour?.businessHour.day ?? 0 {
        case 0:
            day = "Sunday"
        case 1:
            day = "Monday"
        case 2:
            day = "Tuesday"
        case 3:
            day = "Wednesday"
        case 4:
            day = "Thursday"
        case 5:
            day = "Friday"
        case 6:
            day = "Saturday"
        default:
            day = ""
        }
        dayLbl.text = day.uppercased()
        var start = businessHour?.businessHour.start
        start?.insert(string: ".", ind: 2)
        startLbl.text = start?.uppercased()
        var end = businessHour?.businessHour.end
        end?.insert(string: ".", ind: 2)
        endLbl.text = end?.uppercased()
    }

    private func setupViews() {
        dayLbl.style {
            $0.font = .systemFont(ofSize: 14)
        }

        startLbl.style {
            $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            $0.font = .systemFont(ofSize: 14)
        }

        hyphenLbl.style {
            $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            $0.font = .systemFont(ofSize: 14)
            $0.text = "-"
        }

        endLbl.style {
            $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            $0.font = .systemFont(ofSize: 14)
        }
    }

    private func setupConstraints() {
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        dayLbl.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
        }

        startLbl.snp.makeConstraints { make in
            make.leading.equalTo(dayLbl.snp.trailing).offset(16)
            make.top.bottom.equalToSuperview()
        }

        hyphenLbl.snp.makeConstraints { make in
            make.leading.equalTo(startLbl.snp.trailing).offset(4)
            make.top.bottom.equalToSuperview()
        }

        endLbl.snp.makeConstraints { make in
            make.leading.equalTo(hyphenLbl.snp.trailing).offset(4)
            make.top.bottom.trailing.equalToSuperview()
        }

        setNeedsLayout()
        layoutIfNeeded()
    }
}
