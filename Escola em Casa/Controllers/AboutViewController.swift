import UIKit

class AboutViewController: UIViewController {

    // MARK: - Actions

    @IBAction func howAccessClassRoomPressed(_ sender: Any) {
        let viewController = WebViewControllerFactory.create(.howAcess)
        present(viewController, animated: true, completion: nil)
    }

    @IBAction func acessWebSitePressed(_ sender: Any) {
        let viewController = WebViewControllerFactory.create(.website)
        present(viewController, animated: true, completion: nil)
    }
}
