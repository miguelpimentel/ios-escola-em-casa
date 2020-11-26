import WebKit

class SiteWebViewControllerViewController: UIViewController, WKNavigationDelegate {

    // MARK: - Properties

    private lazy var webView: WKWebView = {
        let view = WKWebView()
        view.navigationDelegate = self

        return view
    }()

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if isPrivacyAvailableForDomain(navigationAction.request.url?.host) {
            decisionHandler(.allow)
            return
        } else {
            decisionHandler(.cancel)
        }
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        requestWebView()
    }

    override func loadView() {
        setupView()
    }

    // MARK: - Setup

    private func setupView() {
        view = webView
    }

    // MARK: - Private Methods

    private func requestWebView() {
        let request = URLRequest(url: WebViewURL.main.url)
        webView.load(request)
    }

    private func isPrivacyAvailableForDomain(_ host: String?) -> Bool {
        if let host = host, host.contains("escolaemcasa.se.df.gov.br") {
            return true
        } else {
            return false
        }
    }
}
