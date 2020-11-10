import UIKit
import WebKit

class HowAccessClassRoomViewController: UIViewController {

    // MARK: - Properties

    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://escolaemcasa.se.df.gov.br/index.php/como-acessar/")!
        webView.load(URLRequest(url: url))
    }

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    private func setupLayout() {

    }
}

extension HowAccessClassRoomViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let host = navigationAction.request.url?.host {
            if host.contains("escolaemcasa.se.df.gov.br") {
                decisionHandler(.allow)
                return
            }
        }

        decisionHandler(.cancel)
    }
}
