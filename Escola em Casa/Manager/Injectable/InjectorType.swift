//
//  InjectorType.swift
//  Escola em Casa
//
//  Created by Miguel Pimentel on 29/10/20.
//  Copyright © 2020 Laércio Silva de Sousa Júnior. All rights reserved.
//

import WebKit

enum InjectorType: String {
    case emailBlocker = "injectorEmailBlocker"
    case accountHider = "injectorHideEmailAccount"
    case fixBackButton = "injectorFixButton"
    case userAgent

    func getValue() -> String {
        return getStringValue(forKey: self.rawValue)
    }

    private func getStringValue(forKey key: String) -> String {
        guard let value = Bundle.main.infoDictionary?[key] as? String else { fatalError("Could not found value for key: \(key)") }
        return value
    }
}
