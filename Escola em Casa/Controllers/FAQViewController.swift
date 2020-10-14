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

    var content = [1]

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self

            tableView.tableFooterView = UIView() // Remove empty lines
            tableView.estimatedRowHeight = 2.0
            tableView.rowHeight = UITableView.automaticDimension
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension FAQViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FAQTableViewCell()
        cell.setup()
        cell.delegate = self
        cell.isExpandable = false

        return cell
    }
}

extension FAQViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FAQTableViewCell else { return }

        if cell.isExpandable {
            cell.isExpandable = false
        } else {
            cell.isExpandable = true
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? FAQTableViewCell {
            cell.isExpandable = false
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
