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
