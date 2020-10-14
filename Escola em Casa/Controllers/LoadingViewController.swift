import UIKit
import SmiSdkVpn

class LoadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self,selector: #selector(receivedStateChage), name: NSNotification.Name(rawValue: SDSTATE_CHANGE_NOTIF), object: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @objc func receivedStateChage(notification: NSNotification){
        print("entrou-received-stated-change")

        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "ResultView") as! UITabBarController
        UIApplication.shared.keyWindow?.rootViewController =  resultViewController

        guard let smiResult = notification.object as? SmiResult else { return }

        if smiResult.sdState == SdState.SD_AVAILABLE {
            // TODO: show a banner or message to user, indicating that the data
            //    usage is sponsored and charges do not apply to user data plan
        } else if smiResult.sdState == SdState.SD_NOT_AVAILABLE {
            // TODO: show a banner or message to user, indicating that the data
            //    usage is NOT sponsored and charges apply to user data plan
        } else if smiResult.sdState == SdState.SD_WIFI {
            // TODO: show a banner or message to user, indicating that the data
            //    usage is NOT sponsored and charges apply to user data plan
        }
    }
}
