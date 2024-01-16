
import UIKit
import SmilesUtilities

@objc public class SmilesLoader: NSObject {
    
    @objc public static func show(with message: String? = nil, isClearBackground: Bool = false) {
        
        if let topVC = topMostViewController(), !topVC.children.contains(where: {$0 is LoadingViewController}) {
            let vc = LoadingViewController(message: message, isClearBackground: isClearBackground)
            if let tabBar = topVC.tabBarController {
                tabBar.addChild(asChildViewController: vc, diseredView: tabBar.view)
            } else {
                topVC.addChild(asChildViewController: vc, diseredView: topVC.view)
            }
        }
        
    }
    
    @objc public static func show(on view: UIView, with message: String? = nil, isClearBackground: Bool = false) {
        
        guard !view.subviews.contains(where: { $0 is BlockingActivityIndicator }) else {
            return
        }
        
        let activityIndicator = BlockingActivityIndicator()
        activityIndicator.setupMessage(message: message)
        activityIndicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        activityIndicator.frame = view.bounds
        if isClearBackground {
            activityIndicator.backgroundColor = .clear
        }
        view.addSubview(activityIndicator)
        
    }
    
    @objc public static func dismiss() {
        
        if let topVC = topMostViewController() {
            if let tabBar = topVC.tabBarController {
                if let loadingVC = tabBar.children.first(where: {$0 is LoadingViewController}) {
                    topVC.removeChild(asChildViewController: loadingVC)
                }
            } else {
                if let loadingVC = topVC.children.first(where: {$0 is LoadingViewController}) {
                    topVC.removeChild(asChildViewController: loadingVC)
                }
            }
        }
        
    }
    
    @objc public static func dismiss(from view: UIView) {
        
        view.subviews.filter { $0 is BlockingActivityIndicator }.forEach { obj in
            obj.removeFromSuperview()
        }
        
    }
    
    private static func topMostViewController(controller: UIViewController? = UIApplication.shared.windows.first { $0.isKeyWindow}?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topMostViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topMostViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topMostViewController(controller: presented)
        }
        return controller
    }
    
}
