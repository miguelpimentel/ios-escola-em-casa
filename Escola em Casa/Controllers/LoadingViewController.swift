import UIKit
import SmiSdkVpn

class LoadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        setup()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        if SmiSdk.getVpnSdState()==SdState.SD_WIFI {
            guard let resultViewController = storyBoard.instantiateViewController(withIdentifier: "ResultView") as? UITabBarController else { return }
            UIApplication.shared.keyWindow?.rootViewController =  resultViewController
        }
        if SmiSdk.getVpnSdState()==SdState.SD_AVAILABLE {
            guard let resultViewController = storyBoard.instantiateViewController(withIdentifier: "ResultView") as? UITabBarController else { return }
            UIApplication.shared.keyWindow?.rootViewController =  resultViewController
        }
    }

    @objc func receivedStateChage(notification: NSNotification) {
        print("entrou-received-stated-change")
        guard let smiResult = notification.object as? SmiResult else { return}
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        guard let resultViewController = storyBoard.instantiateViewController(withIdentifier: "ResultView") as? UITabBarController else { return }
        UIApplication.shared.keyWindow?.rootViewController =  resultViewController

        if smiResult.sdState==SdState.SD_AVAILABLE {
            // TODO: show a banner or message to user, indicating that the data
            //    usage is sponsored and charges do not apply to user data plan
        } else if smiResult.sdState==SdState.SD_NOT_AVAILABLE {
            // TODO: show a banner or message to user, indicating that the data
            //    usage is NOT sponsored and charges apply to user data plan
        } else if smiResult.sdState==SdState.SD_WIFI {

        }
    }

    // MARK: - Private Methods

    private func setup() {
        addObservers()
    }

    private func addObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(receivedStateChage),
            name: NSNotification.Name(rawValue: SDSTATE_CHANGE_NOTIF),
            object: nil
        )
    }
}
