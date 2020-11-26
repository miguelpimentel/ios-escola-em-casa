import UIKit
import WebKit
import SnapKit

class SiteWebViewControllerViewController: UIViewController {

//    var webView: WKWebView!
//
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//        if let host = navigationAction.request.url?.host {
//            if host.contains("escolaemcasa.se.df.gov.br") {
//                decisionHandler(.allow)
//                return
//            }
//        }
//
//        decisionHandler(.cancel)
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.view.addSubview(itemView)
//
//        baseView.backgroundColor = .red
//        let url = URL(string: "https://escolaemcasa.se.df.gov.br/")!
//        webView.load(URLRequest(url: url))
//
//        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
//        toolbarItems = [refresh]
//    }
//
//    override func loadView() {
//        baseView.delegate = self
//        webView = WKWebView()
//        webView.navigationDelegate = self
//        view = webView
//    }
}
