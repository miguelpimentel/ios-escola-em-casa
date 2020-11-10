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

class NetworkManager {

    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(observeConnection),
            name: NSNotification.Name(rawValue: SDSTATE_CHANGE_NOTIF),
            object: nil
        )
    }

    func verifyConnection() {
        let connectionState = SmiSdk.getVpnSdState()

        if connectionState == SdState.SD_WIFI {
            // Loader.stop()
        } else if connectionState == SdState.SD_AVAILABLE {
            // Loader.stop()
        }
    }

    // MARK: - Observers

    @objc func observeConnection(notification: NSNotification) {
        guard let result = notification.object as? SmiResult else { return }

        switch result.sdState {
        case SdState.SD_AVAILABLE:
            // TODO: show a banner or message to user, indicating that the data
            break
        case SdState.SD_NOT_AVAILABLE:
            // TODO: show a banner or message to user, indicating that the data
            break
        case SdState.SD_WIFI:
            // TODO: show a banner or message to user, indicating that the data
            break
        default:
            break
        }
    }
}
