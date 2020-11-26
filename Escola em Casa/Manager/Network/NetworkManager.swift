//
//  NetworkManager.swift
//  Escola em Casa
//
//  Created by Miguel Pimentel on 11/10/20.
//  Copyright © 2020 Laércio Silva de Sousa Júnior. All rights reserved.
//

import Foundation
import UIKit
import SmiSdkVpn

protocol NetworkManagerDelegate: class {
    func didReceiveResult(_ result: SmiResult)
}

class NetworkManager {

    weak var delegate: NetworkManagerDelegate?

    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(observeConnection),
            name: NSNotification.Name(rawValue: SDSTATE_CHANGE_NOTIF),
            object: nil
        )
    }

    // MARK: - Observer

    @objc func observeConnection(notification: NSNotification) {
        guard let result = notification.object as? SmiResult else { return }
        delegate?.didReceiveResult(result)
    }
}
