//
//  InjectableManager.swift
//  Escola em Casa
//
//  Created by Miguel Pimentel on 29/10/20.
//  Copyright © 2020 Laércio Silva de Sousa Júnior. All rights reserved.
//

import WebKit

struct InjectorManager {

    static func inject(_ injectors: [InjectorType], into webView: WKWebView) {
        injectors.forEach {
            let script = WKUserScript(source: $0.getValue(), injectionTime: .atDocumentEnd, forMainFrameOnly: false)
            webView.configuration.userContentController.addUserScript(script)
        }
    }
}
