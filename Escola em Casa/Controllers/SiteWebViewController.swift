import UIKit
import WebKit

class SiteWebViewControllerViewController: UIViewController, WKNavigationDelegate {

    // MARK: - Properties

    var webView: WKWebView!

    lazy var url: URL = {
        guard let url = URL(string: "https://escolaemcasa.se.df.gov.br/") else { fatalError("A valid URL must be provided") }
        return url
    }()

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let host = navigationAction.request.url?.host {
            if host.contains("escolaemcasa.se.df.gov.br") {
                decisionHandler(.allow)
                return
            }
        }

        decisionHandler(.cancel)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://escolaemcasa.se.df.gov.br/")!
        webView.load(URLRequest(url: url))

        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [refresh]
    }

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
}
