import UIKit
import SmiSdkVpn

class LoadingViewController: UIViewController {

     override func viewDidLoad() {
         super.viewDidLoad()
         addObservers()
     }

     override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)

         if (SmiSdk.getVpnSdState()==SdState.SD_WIFI){
             guard let resultViewController = Storyboards.main.getViewController() as? UITabBarController else { return }
             navigationController?.pushViewController(resultViewController, animated: true)
         }
         if (SmiSdk.getVpnSdState()==SdState.SD_AVAILABLE){
            guard let resultViewController = Storyboards.main.getViewController() as? UITabBarController else { return }
            navigationController?.pushViewController(resultViewController, animated: true)
         }
     }

     @objc func receivedStateChage(notification: NSNotification){
        print("entrou-received-stated-change")
        let sr = notification.object as! SmiResult

        guard let resultViewController = Storyboards.main.getViewController() as? UITabBarController else { return }
        navigationController?.pushViewController(resultViewController, animated: true)

        if sr.sdState==SdState.SD_AVAILABLE {
             // TODO: show a banner or message to user, indicating that the data
             //    usage is sponsored and charges do not apply to user data plan
        } else if sr.sdState==SdState.SD_NOT_AVAILABLE {
             // TODO: show a banner or message to user, indicating that the data
             //    usage is NOT sponsored and charges apply to user data plan
        } else if sr.sdState==SdState.SD_WIFI {
            // TODO: show a banner or message to user, indicating that the data
            //    usage is NOT sponsored and charges apply to user data plan
        }
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
