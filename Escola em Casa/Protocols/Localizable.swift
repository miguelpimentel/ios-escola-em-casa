//
//  Localizable+Extension.swift
//  Escola em Casa
//
//  Created by Miguel Pimentel on 26/11/20.
//  Copyright © 2020 Laércio Silva de Sousa Júnior. All rights reserved.
//

import Foundation

protocol Localizable {
    var text: String? { get }
}

extension Localizable {

    func getText(for key: String) -> String? {
        return NSLocalizedString(key, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
