import UIKit
import SmiSdkVpn

class LoadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver( self,selector: #selector(receivedStateChage), name: NSNotification.Name(rawValue: SDSTATE_CHANGE_NOTIF), object: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
//        if (SmiSdk.getVpnSdState()==SdState.SD_WIFI){
//            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "ResultView") as! UITabBarController
//            UIApplication.shared.keyWindow?.rootViewController =  resultViewController
//        }
//        if (SmiSdk.getVpnSdState()==SdState.SD_AVAILABLE){
//            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "ResultView") as! UITabBarController
//            UIApplication.shared.keyWindow?.rootViewController =  resultViewController
//        }
    }

    @objc func receivedStateChage(notification: NSNotification){
        print("entrou-received-stated-change")
//        let sr = notification.object as! SmiResult
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "ResultView") as! UITabBarController
        UIApplication.shared.keyWindow?.rootViewController =  resultViewController
//
//        if sr.sdState==SdState.SD_AVAILABLE {
//            // TODO: show a banner or message to user, indicating that the data
//            //    usage is sponsored and charges do not apply to user data plan
//        }
//        else if sr.sdState==SdState.SD_NOT_AVAILABLE {
//            // TODO: show a banner or message to user, indicating that the data
//            //    usage is NOT sponsored and charges apply to user data plan
//        }
//        else if sr.sdState==SdState.SD_WIFI {
//        }
    }
}
