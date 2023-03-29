import UIKit
import NVActivityIndicatorView

open class SmilesLoader {
    
    private static var keyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first
    }
    
    public static func show() {
        
        if let window = keyWindow {
            guard !window.subviews.contains(where: { $0 is BlockingActivityIndicator }) else {
                return
            }
            
            let activityIndicator = BlockingActivityIndicator()
            activityIndicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            activityIndicator.frame = window.bounds
            
            UIView.transition(
                with: window,
                duration: 0.3,
                options: .transitionCrossDissolve,
                animations: {
                    window.addSubview(activityIndicator)
                }
            )
        }
        
    }
    
    public static func dismiss() {
        
        if let window = keyWindow {
            window.subviews.filter { $0 is BlockingActivityIndicator }.forEach { view in
                view.removeFromSuperview()
            }
        }
    }
    
}

final class BlockingActivityIndicator: UIView {
    
    private let activityIndicator: NVActivityIndicatorView
    
    override init(frame: CGRect) {
        self.activityIndicator = NVActivityIndicatorView(
            frame: CGRect(
                origin: .zero,
                size: NVActivityIndicatorView.DEFAULT_BLOCKER_SIZE
            )
        )
        activityIndicator.type = .ballScale
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        super.init(frame: frame)
        backgroundColor = UIColor.black.withAlphaComponent(0.6)
        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
