import UIKit
import IQKeyboardManagerSwift
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
       
        let rootViewController: UIViewController
        
        if let email = UserDefaultsManager.shared.getEmail() {
            rootViewController = TabBarViewController()
        } else {
            rootViewController = OnboardingCollectionViews()
        }
        
        let mainNavigationVC = UINavigationController(rootViewController: rootViewController)
        
        if UserDefaultsManager.shared.getEmail() != nil {
            mainNavigationVC.setNavigationBarHidden(true, animated: false)
        }
    
        window?.rootViewController = mainNavigationVC
        window?.makeKeyAndVisible()
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.resignOnTouchOutside = true
        
        return true
    }
}
