//
//  FAQLocalizable.swift
//  Escola em Casa
//
//  Created by Miguel Pimentel on 26/11/20.
//  Copyright © 2020 Laércio Silva de Sousa Júnior. All rights reserved.
//

import Foundation

enum FAQLocalizable: String {
    case question1 = "faq_question1"
    case answer1 = "faq_answer1"
    case question2 = "faq_question2"
    case answer2 = "faq_answer2"
    case question3 = "faq_question3"
    case answer3 = "faq_answer3"
}

extension FAQLocalizable: Localizable {

    var text: String? {
        getText(for: self.rawValue)
    }
}
