//
//  WebViewFactory.swift
//  Escola em Casa
//
//  Created by Miguel Pimentel on 06/12/20.
//  Copyright © 2020 Laércio Silva de Sousa Júnior. All rights reserved.
//

import UIKit

enum WebViewType {
    case howAcess
    case website
}

struct WebViewControllerFactory {

    static func create(_ type: WebViewType) -> UIViewController {
        switch type {
        case .howAcess:
            return HowAccessClassRoomViewController(domain: "escolaemcasa.se.df.gov.br", url: WebViewURL.howAcess.url)
        case .website:
            return SiteWebViewControllerViewController(domain: "escolaemcasa.se.df.gov.br", url: WebViewURL.main.url)
        }
    }
}
