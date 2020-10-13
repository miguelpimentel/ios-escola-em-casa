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

            tableView.separatorStyle = .none
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
        cell.isExpanded = false

        return cell
    }
}

extension FAQViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FAQTableViewCell else { return }

        UIView.animate(withDuration: 0.3, animations: {
            tableView.beginUpdates()
            cell.isExpanded = !cell.isExpanded
            tableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.top, animated: true)
            tableView.reloadData()
            tableView.endUpdates()
        })
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FAQTableViewCell else { return }

        UIView.animate(withDuration: 0.3, animations: {
            tableView.beginUpdates()
            cell.isExpanded = false
            tableView.endUpdates()
            tableView.reloadData()
        })
    }
}
