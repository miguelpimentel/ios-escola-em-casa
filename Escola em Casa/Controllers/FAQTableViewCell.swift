//
//  FAQTableViewCell.swift
//  Escola em Casa
//
//  Created by Miguel Pimentel on 13/10/20.
//  Copyright © 2020 Laércio Silva de Sousa Júnior. All rights reserved.
//  swiftlint:disable line_length

import UIKit
import SnapKit

protocol FAQTableViewCellDelegate: class {
    func willLayoutChange(_ cell: FAQTableViewCell)
}

class FAQTableViewCell: UITableViewCell {

    // MARK: - Properties

    weak var delegate: FAQTableViewCellDelegate?

    var isExpanded: Bool = false {
        didSet {
            descriptionTextView.isHidden = !isExpanded
            delegate?.willLayoutChange(self)
        }
    }

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 10

        return stackView
    }()

    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 10

        return stackView
    }()

    private lazy var selectorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_arrow_down")

        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        label.numberOfLines = 3
        label.textColor =  AppColors.primaryColor

        return label
    }()

    private lazy var descriptionTextView: UITextView = {
        let style = NSMutableParagraphStyle()
        let textView = UITextView()
        textView.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        textView.textColor = .gray

        return textView
    }()

    // MARK: - Methods

    func setup(_ FAQ: FAQModels.FAQ) {
        setupViews()
        setupConstraints()

        titleLabel.text = FAQ.title
        descriptionTextView.text = FAQ.description
    }

    private func setupViews() {
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionTextView)

        selectionStyle = .none
    }

    private func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }

        titleLabel.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(15)
        }

        descriptionTextView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.greaterThanOrEqualTo(110)
        }
    }
}
