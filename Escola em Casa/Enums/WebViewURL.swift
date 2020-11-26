//
//  WebViewURL.swift
//  Escola em Casa
//
//  Created by Miguel Pimentel on 23/11/20.
//  Copyright © 2020 Laércio Silva de Sousa Júnior. All rights reserved.
//

import Foundation

enum WebViewURL {
    case main
    case howAcess
    case wikipedia
    case googleClassroom

    var url: URL {
        switch self {
        case .main:
            return URL(string: "https://escolaemcasa.se.df.gov.br/")!
        case .howAcess:
            return URL(string: "https://escolaemcasa.se.df.gov.br/index.php/como-acessar/")!
        case .wikipedia:
            return URL(string: "https://pt.wikipedia.org/")!
        case .googleClassroom:
            return URL(string: "https://classroom.google.com/a/estudante.se.df.gov.br")!
        }
    }
}
