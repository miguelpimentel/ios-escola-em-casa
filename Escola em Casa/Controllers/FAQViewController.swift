//
//  FAQViewController.swift
//  Escola em Casa
//
//  Created by Miguel Pimentel on 13/10/20.
//  Copyright © 2020 Laércio Silva de Sousa Júnior. All rights reserved.
//

import UIKit
import SnapKit

class FAQViewController: UIViewController {

    // MARK: - Properties

    var content: [FAQModels.FAQ] = FAQModels.content {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self

        tableView.tableFooterView = UIView() // Remove empty lines
        tableView.rowHeight = UITableView.automaticDimension

        return tableView
    }()

    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "FAQ"
        label.font = UIFont(descriptor: UIFontDescriptor(), size: 38)
        label.textColor = AppColors.primaryColor
        label.textAlignment = .center

        return label
    }()

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .default
        searchBar.placeholder = "Qual sua dúvida?"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self

        return searchBar
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupConstraints()
    }

    // MARK: - Setup

    private func setupLayout() {
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(searchBar)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(50)
        }

        searchBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom)
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension FAQViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        filter(with: textSearched)
    }

    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        content = FAQModels.content
    }

    private func filter(with keyword: String) {
        let textLowerCased = keyword.lowercased()
        if textLowerCased.isEmpty {
            content = FAQModels.content
        } else {
            content = FAQModels.content.filter {
                ($0.title.lowercased().contains(textLowerCased) || $0.description.lowercased().contains(textLowerCased))
            }
        }
    }
}

extension FAQViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FAQTableViewCell()

        cell.setup(content[indexPath.row])
        cell.delegate = self
        cell.isExpanded = false

        return cell
    }
}

extension FAQViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FAQTableViewCell else { return }

        if cell.isExpanded {
            cell.isExpanded = false
        } else {
            cell.isExpanded = true
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? FAQTableViewCell {
            cell.isExpanded = false
        }
    }
}

extension FAQViewController: FAQTableViewCellDelegate {

    func willLayoutChange(_ cell: FAQTableViewCell) {
        self.tableView.beginUpdates()
        self.tableView.setNeedsDisplay()
        self.tableView.endUpdates()
    }
}

struct FAQModels {

    static var content: [FAQ] = [
        FAQ(title: FAQLocalizable.question1.text!, description: FAQLocalizable.answer1.text!),
        FAQ(title: FAQLocalizable.question2.text!, description: FAQLocalizable.answer2.text!),
        FAQ(title: FAQLocalizable.question3.text!, description: FAQLocalizable.answer3.text!)
    ]

    struct FAQ {
        var title: String
        var description: String
    }
}
