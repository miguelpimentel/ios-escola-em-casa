//
//  BaseWebViewController.swift
//  Escola em Casa
//
//  Created by Miguel Pimentel on 06/12/20.
//  Copyright © 2020 Laércio Silva de Sousa Júnior. All rights reserved.
//

import UIKit
import WebKit

protocol BaseViewControllerDataSource {
    init(domain: String, url: URL)
}

class BaseWebViewController: UIViewController {

    // MARK: - Properties

    var webView: WKWebView!

    var domain: String
    var url: URL

    // MARK: - Initialize

    init(domain: String, url: URL) {
        self.domain = domain
        self.url = url

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadUrl()
        Loader.start(loaderColor: AppColors.primaryColor)
    }

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    private func loadUrl() {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

extension BaseWebViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if isPrivacyAvailableForDomain(navigationAction.request.url?.host) {
            decisionHandler(.allow)
            return
        } else {
            decisionHandler(.cancel)
        }
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        Loader.stop()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        Loader.stop()
    }

    private func isPrivacyAvailableForDomain(_ host: String?) -> Bool {
//        let filterKey = "escolaemcasa.se.df.gov.br"
        if let host = host, host.contains(domain) {
            return true
        } else {
            return false
        }
    }
}
