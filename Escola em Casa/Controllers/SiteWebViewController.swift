import UIKit
import WebKit

class SiteWebViewControllerViewController: UIViewController, WKNavigationDelegate {

    // MARK: - Properties
    
    var webView: WKWebView!

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
        navigationController?.isToolbarHidden = false
    }
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }


}
