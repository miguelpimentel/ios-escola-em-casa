import UIKit
import WebKit

class GCWebViewController: UIViewController, WKUIDelegate {

    // MARK: - Properties

    @IBOutlet weak var activity: UIActivityIndicatorView! {
        didSet {
            activity.hidesWhenStopped = true
        }
    }

    lazy var webView: WKWebView = {
        var webView = WKWebView()
        webView.addSubview(activity)
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true

        return webView
    }()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

    override func loadView() {
        super.loadView()
        setupViews()
    }

    // MARK: - Setup

    private func setupViews() {
        webView = WKWebView(frame: view.frame)
        view.addSubview(webView)

        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [refresh]

        setupWebView()
    }

    private func setupLayout() {
        requestWebView()
        activity.startAnimating()
    }

    private func setupWebView() {
        let injectors: [InjectorType] = [.emailBlocker, .accountHider, .fixBackButton]

        webView.customUserAgent = InjectorType.userAgent.getValue()
        webView.navigationDelegate = self
        webView.uiDelegate = self

        InjectorManager.inject(injectors, into: webView)
    }

    // MARK: - Private Methods

    private func requestWebView() {
        let request = URLRequest(url: WebViewURL.googleClassroom.url)
        webView.load(request)
    }
}

extension GCWebViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activity.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activity.stopAnimating()
    }

    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            if let host = navigationAction.request.url?.host {
                let url = (navigationAction.request.url?.absoluteString ?? "")
                if !host.contains("youtube.com") && !host.contains("drive.google") && !url.contains("spreadsheets") {
                    webView.load(navigationAction.request)
                }
            }
        }

        return nil
    }

    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: "Alerta!", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
        completionHandler()
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

        if let host = navigationAction.request.url?.host {
            if host.contains("google.com") {
                decisionHandler(.allow)
                return
            }
            if host.contains("youtube.com") {
                if let hostSource = navigationAction.sourceFrame.request.url?.host {
                    if hostSource.contains("google.com") {
                        decisionHandler(.allow)
                        return
                    }
                }
            }
        }

        decisionHandler(.cancel)
    }
}
