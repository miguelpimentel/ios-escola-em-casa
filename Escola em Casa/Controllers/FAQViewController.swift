//
//  FAQViewController.swift
//  Escola em Casa
//
//  Created by Miguel Pimentel on 13/10/20.
//  Copyright © 2020 Laércio Silva de Sousa Júnior. All rights reserved.
//  swiftlint:disable line_length

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
        FAQ(
            title: "Os dados móveis de internet do aplicativo já estão sendo pagos pelo governo?",
            description: "Os dados móveis de internet já estão sendo patrocinados (pagos) pelo Governo do Distrito Federal. No momento, é possivel fazer uso dos dados utilizando chips ativos das operadoras Claro e Tim"
        ),
        FAQ(
            title: "O governo pagará pelo uso da plataforma Meet Google?",
            description: "Mesmo quando liberado o patrocínio dos dados, não será pago pelo Governo o uso da plataforma Meet Google, pois só é possível utilizá-la através do seu próprio  aplicativo. É responsabilidade do governo arcar somente pelas plataformas que são abertas dentro do nosso próprio aplicativo, Escola em Casa DF."
        ),
        FAQ(
            title: "Se eu rotear a internet do celular para o computador, os dados móveis de internet serão pagos pelo governo?",
            description: "Não serão patrocinados (pagos) os dados móveis de internet quando roteados, ou compartilhados, com outros dispositivos e/ou computadores."
        )
    ]

    struct FAQ {
        var title: String
        var description: String
    }
}
