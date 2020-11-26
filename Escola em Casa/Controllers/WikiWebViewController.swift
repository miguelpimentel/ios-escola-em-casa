import UIKit
import WebKit

class WikiWebViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet weak var activity: UIActivityIndicatorView!

    var webView: WKWebView!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        load()
        setupActivity()
    }

    override func loadView() {
        super.loadView()
        setupLayout()
    }

    private func load() {
        let request = URLRequest(url: WebViewURL.wikipedia.url)
        webView.load(request)
    }

    private func removeWebViewAdds(_ webview: WKWebView) -> WKWebView {
        let jsRemoveDonationButton = "javascript:(function f() {" +
            "document.getElementById('p-donation').style.display='none'; " +
            "})()"

        let jsScriptRemoveDonationButton = WKUserScript(source: jsRemoveDonationButton, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        webView.configuration.userContentController.addUserScript(jsScriptRemoveDonationButton)

        return webview
    }

    private func setupLayout() {
        webView = createWebView()
        webView = removeWebViewAdds(webView)
        view  = webView

    }

    private func setupActivity() {
        webView.addSubview(self.activity)

        self.activity.startAnimating()
        self.activity.hidesWhenStopped = true
    }

    private func createWebView() -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self

        return webView
    }
}

extension WikiWebViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activity.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activity.stopAnimating()
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }

        if let host = navigationAction.request.url?.host {
            if host.contains("wikipedia.org") {
                decisionHandler(.allow)
                return
            }
        }

        decisionHandler(.cancel)
    }
}
