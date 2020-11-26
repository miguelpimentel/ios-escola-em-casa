//
//  InjectableStrings.swift
//  Escola em Casa
//
//  Created by Miguel Pimentel on 26/11/20.
//  Copyright © 2020 Laércio Silva de Sousa Júnior. All rights reserved.
//

import Foundation

enum InjectableStrings: String {
    case wikipediaInjection = "wiki_injection"
}

extension InjectableStrings: Localizable {

    var text: String? {
        getText(for: self.rawValue)
    }
}
