
import UIKit
import SmilesUtilities

@objc public class SmilesLoader: NSObject {
    
    private static var keyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first
    }
    private static var loaderViewTag = 999
    
    @objc public static func show(with message: String? = nil, isClearBackground: Bool = false) {
        
        if let window = keyWindow {
            guard window.viewWithTag(loaderViewTag) == nil else {
                return
            }
            let loader = createLoader(with: message, frame: window.bounds, isClearBackground: isClearBackground)
            loader.tag = loaderViewTag
            window.addSubview(loader)
        }
        
    }
    
    @objc public static func show(on view: UIView, with message: String? = nil, isClearBackground: Bool = false) {
        
        guard view.viewWithTag(loaderViewTag) == nil else {
            return
        }
        let loader = createLoader(with: message, frame: view.bounds, isClearBackground: isClearBackground)
        loader.tag = loaderViewTag
        view.addSubview(loader)
        
    }
    
    @objc public static func dismiss() {
        
        if let window = keyWindow, let loader = window.viewWithTag(loaderViewTag) {
            loader.removeFromSuperview()
        }
        
    }
    
    @objc public static func dismiss(from view: UIView) {
        
        if let loader = view.viewWithTag(loaderViewTag) {
            loader.removeFromSuperview()
        }
        
    }
    
    private static func createLoader(with message: String?, frame: CGRect, isClearBackground: Bool) -> BlockingActivityIndicator {
        
        let activityIndicator = BlockingActivityIndicator()
        activityIndicator.setupMessage(message: message)
        activityIndicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        activityIndicator.frame = frame
        if isClearBackground {
            activityIndicator.backgroundColor = .clear
        }
        return activityIndicator
        
    }
    
}
