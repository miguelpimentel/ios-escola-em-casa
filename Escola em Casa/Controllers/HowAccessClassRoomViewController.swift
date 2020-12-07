import UIKit
import WebKit

class HowAccessClassRoomViewController: BaseWebViewController, BaseViewControllerDataSource {

    required override init(domain: String, url: URL) {
        super.init(domain: domain, url: url)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//    // MARK: - Properties

//
//    var webView: WKWebView!
//    var domain: String = ""
//    var url: URL!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        loadUrl()
//    }
//
//    override func loadView() {
//        webView = WKWebView()
//        webView.navigationDelegate = self
//        view = webView
//    }
//
//    private func loadUrl() {
//        let request = URLRequest(url: WebViewURL.howAcess.url)
//        webView.load(request)
//    }
//}

//extension HowAccessClassRoomViewController: WKNavigationDelegate {
//
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//        if isPrivacyAvailableForDomain(navigationAction.request.url?.host) {
//            decisionHandler(.allow)
//            return
//        } else {
//            decisionHandler(.cancel)
//        }
//    }
//
//    private func isPrivacyAvailableForDomain(_ host: String?) -> Bool {
//        let filterKey = "escolaemcasa.se.df.gov.br"
//        if let host = host, host.contains(filterKey) {
//            return true
//        } else {
//            return false
//        }
//    }
//}
