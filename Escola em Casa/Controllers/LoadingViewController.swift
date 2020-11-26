import UIKit
import SmiSdkVpn

class LoadingViewController: UIViewController {

    // MARK: - Properties

    var networkManager: NetworkManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - Private Methods

    private func setup() {
        networkManager = NetworkManager()
        networkManager?.delegate = self
    }
}

extension LoadingViewController: NetworkManagerDelegate {

    func didReceiveResult(_ result: SmiResult) {
        switch result.sdState {
        case .SD_AVAILABLE:
            openHomeScreen()
        case .SD_WIFI:
            openHomeScreen()
        default:
            break
        }
    }

    private func openHomeScreen() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        guard let resultViewController = storyboard.instantiateViewController(withIdentifier: "ResultView") as? UITabBarController else { return }
        UIApplication.shared.keyWindow?.rootViewController =  resultViewController
    }
}
