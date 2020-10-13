//
//  FAQTableViewCell.swift
//  Escola em Casa
//
//  Created by Miguel Pimentel on 13/10/20.
//  Copyright © 2020 Laércio Silva de Sousa Júnior. All rights reserved.
//

import UIKit
import SnapKit

protocol FAQTableViewCellDelegate: class {
    func willLayoutChange(_ cell: FAQTableViewCell)
}

class FAQTableViewCell: UITableViewCell {

    // MARK: - Properties

    var isExpanded: Bool = false {
        didSet {
            if !isExpanded {
                descriptionTextView.snp.makeConstraints { $0.height.equalTo(0) }
            } else {
                descriptionTextView.snp.makeConstraints {
                    $0.width.equalToSuperview().inset(10)
                    $0.height.greaterThanOrEqualTo(100)
                }
            }
        }
    }

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 10

        return stackView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "O governo pagará pelo uso da plataforma Meet Google?"
        label.numberOfLines = 2
        label.textColor = .red

        return label
    }()

    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
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
    }

    private func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.lessThanOrEqualTo(200)
        }

        titleLabel.snp.makeConstraints {
            $0.width.equalToSuperview().inset(10)
            $0.height.greaterThanOrEqualTo(20)
        }

        descriptionTextView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(0)
        }
    }
}
