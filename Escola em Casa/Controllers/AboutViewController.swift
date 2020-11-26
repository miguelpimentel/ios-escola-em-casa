import UIKit

class AboutViewController: UIViewController {

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Actions

    @IBAction func howAccessClassRoomPressed(_ sender: Any) {
        let viewController = Storyboards.howAccess.getViewController()
        present(viewController, animated: true, completion: nil)
    }

    @IBAction func acessWebSitePressed(_ sender: Any) {
        let viewController = Storyboards.site.getViewController()
        present(viewController, animated: true, completion: nil)
    }
}
