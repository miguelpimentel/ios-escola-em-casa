//
//  FAQTableViewCell.swift
//  Escola em Casa
//
//  Created by Miguel Pimentel on 13/10/20.
//  Copyright © 2020 Laércio Silva de Sousa Júnior. All rights reserved.
//

import UIKit
import SnapKit

protocol Theme: class {
    static var primaryColor: UIColor { get}
}

class AppColors: Theme {

    static var primaryColor: UIColor {
        return UIColor(displayP3Red: 0.2667, green: 0.5725, blue: 0.8745, alpha: 1.0)
    }
}

protocol FAQTableViewCellDelegate: class {
    func willLayoutChange(_ cell: FAQTableViewCell)
}

class FAQTableViewCell: UITableViewCell {

    // MARK: - Properties

    var delegate: FAQTableViewCellDelegate?

    var isExpandable: Bool = false {
        didSet {
            descriptionTextView.isHidden = !isExpandable
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
        label.text = "O governo pagará pelo uso da plataforma Meet Google?"
        label.font = UIFont(name: "HelveticaNeue-Regular", size: 16)
        label.numberOfLines = 2
        label.textColor =  AppColors.primaryColor

        return label
    }()

    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "HelveticaNeue-Regular", size: 14)
        textView.textColor = .darkGray
        textView.text = "Mesmo quando liberado o patrocínio dos dados, não será pago pelo Governo o uso da plataforma Meet Google, pois só é possível utilizá-la através do seu próprio  aplicativo. É responsabilidade do governo arcar somente pelas plataformas que são abertas dentro do nosso próprio aplicativo, Escola em Casa DF."

        return textView
    }()

    // MARK: - Methods

    func setup() {
        setupViews()
        setupConstraints()
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
            $0.height.greaterThanOrEqualTo(20)
        }

        descriptionTextView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.greaterThanOrEqualTo(100)
        }
    }
}
