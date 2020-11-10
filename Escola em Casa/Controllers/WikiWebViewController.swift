import UIKit
import WebKit

class WikiWebViewController: UIViewController, WKNavigationDelegate {

    // MARK: - Properties

    @IBOutlet weak var activity: UIActivityIndicatorView!

    var webView: WKWebView!

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activity.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activity.stopAnimating()
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
            print("Lançamento de nova aba")
        }

        if let host = navigationAction.request.url?.host {
            if host.contains("wikipedia.org") {
                decisionHandler(.allow)
                return
            }
        }

        print("Request Bloqueada")

        decisionHandler(.cancel)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://pt.wikipedia.org/")!

        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true

        self.webView.addSubview(self.activity)
        self.activity.startAnimating()
        self.webView.navigationDelegate = self
        self.activity.hidesWhenStopped = true
    }

    override func loadView() {
        super.loadView()

        let statusBarHeight = UIApplication.shared.statusBarFrame.height

        let screenSize: CGRect = UIScreen.main.bounds
        let subView = UIView(frame: CGRect(x: 0, y: statusBarHeight, width: screenSize.width, height: screenSize.height-statusBarHeight))

        view.addSubview(subView)

        webView = WKWebView(frame: subView.frame)

        view.addSubview(webView)
        webView.navigationDelegate = self

        let jsRemoveDonationButton = "javascript:(function f() {" +
            "document.getElementById('p-donation').style.display='none'; " +
            "})()"

        let jsScriptRemoveDonationButton = WKUserScript(source: jsRemoveDonationButton, injectionTime: .atDocumentEnd, forMainFrameOnly: false)

        webView.configuration.userContentController.addUserScript(jsScriptRemoveDonationButton)
    }
}
