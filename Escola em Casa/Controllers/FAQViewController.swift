//
//  FAQViewController.swift
//  Escola em Casa
//
//  Created by Miguel Pimentel on 13/10/20.
//  Copyright © 2020 Laércio Silva de Sousa Júnior. All rights reserved.
//

import UIKit

class FAQViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self

            tableView.tableFooterView = UIView() // Remove empty lines
            tableView.estimatedRowHeight = 2.0
            tableView.rowHeight = UITableView.automaticDimension
        }
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension FAQViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FAQModels.content.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FAQTableViewCell()

        cell.setup(FAQModels.content[indexPath.row])
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
        FAQ(title: FAQLocalizable.question1.text, description: FAQLocalizable.answer1.text),
        FAQ(title: FAQLocalizable.question2.text, description: FAQLocalizable.answer2.text),
        FAQ(title: FAQLocalizable.question3.text, description: FAQLocalizable.answer3.text)
    ]

    struct FAQ {
        var title: String?
        var description: String?
    }
}
