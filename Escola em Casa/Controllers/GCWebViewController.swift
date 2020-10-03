import UIKit
import WebKit

class GCWebViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    // MARK: - Properties

    @IBOutlet weak var activity: UIActivityIndicatorView!

//    lazy var webView: WKWebView = {
//        let webview = WKWebView(frame: view.bounds)
//
//        return webview\
//    }()

    var webView: WKWebView!

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

        print("Request Bloqueada")

        decisionHandler(.cancel)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://classroom.google.com/a/estudante.se.df.gov.br")!

        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true

        // add activity
        self.webView.addSubview(self.activity)
        self.activity.startAnimating()
        self.webView.navigationDelegate = self
        self.activity.hidesWhenStopped = true

        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [refresh]
        navigationController?.isToolbarHidden = false
    }

    override func loadView() {
        super.loadView()

        let statusBarHeight = UIApplication.shared.statusBarFrame.height

        let screenSize: CGRect = UIScreen.main.bounds
        let subView = UIView(frame: CGRect(x: 0, y: statusBarHeight, width: screenSize.width, height: screenSize.height-statusBarHeight))

        view.addSubview(subView)

        // TODO: Create injectable manager
        let jsCodeEmailBlocker = "javascript:(function f(e) {" +
            "var email = document.getElementsByName('identifier');" +
            "var submitBtn = document.getElementsByClassName('VfPpkd-LgbsSe VfPpkd-LgbsSe-OWXEXe-k8QpJ VfPpkd-LgbsSe-OWXEXe-dgl2Hf nCP5yc AjY5Oe DuMIQc qIypjc TrZEUc')[0];" +

            "email[0].oninput = function(value) {" +
                "if(!/^\\w?([\\.-]?\\w+)*(@)?((e(d(u)?)?)?|(e(s(t(u(d(a(n(t(e)?)?)?)?)?)?)?)?)?)?(\\.)?(s(e(\\.(d(f(\\.(g(o(v(\\.(b(r)?)?)?)?)?)?)?)?)?)?)?)?$/.test(email[0].value)){" +
                    "email[0].value = email[0].value.split('@')[0];" +
                    "alert('São permitidos apenas emails com domínio: @edu.se.df.gov.br ou @estudante.se.df.gov.br ou @se.df.gov.br');" +
                    "return false;" +
                "}" +
            "}" +
        "})()"

        let jsCodeCreateAccountHider = "javascript:(function f() {" +
            "document.getElementsByClassName('OIPlvf')[0].style.display='none'; " +
            "document.getElementsByClassName('Y4dIwd')[0].innerHTML = 'Use sua conta Google Sala De Aula (@edu.se.df.gov.br ou @estudante.se.df.gov.br ou @se.df.gov.br)'" +
        "})()"

        let jsCodeFixBackButton = "javascript:(function f() {" +
            "document.getElementsByClassName('docs-ml-header-item docs-ml-header-drive-link')[0].style.display='none'; " +
        "})()"

        let jsScriptCreateAccountHider = WKUserScript(source: jsCodeCreateAccountHider, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        let jsScriptEmailBlocker = WKUserScript(source: jsCodeEmailBlocker, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        let jsScriptFixBackButton = WKUserScript(source: jsCodeFixBackButton, injectionTime: .atDocumentEnd, forMainFrameOnly: false)

        webView = WKWebView(frame: subView.frame)

        webView.customUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1"

        view.addSubview(webView)
        webView.navigationDelegate = self
        webView.uiDelegate = self

        webView.configuration.userContentController.addUserScript(jsScriptCreateAccountHider)
        webView.configuration.userContentController.addUserScript(jsScriptEmailBlocker)
        webView.configuration.userContentController.addUserScript(jsScriptFixBackButton)
    }

}
