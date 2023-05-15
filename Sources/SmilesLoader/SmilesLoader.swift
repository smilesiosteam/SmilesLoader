import UIKit
import NVActivityIndicatorView
import SmilesFontsManager

@objc public class SmilesLoader: NSObject {
    
    private static var keyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first
    }
    
    @objc public static func show(with message: String? = nil, isClearBackground: Bool = false) {
        
        if let window = keyWindow {
            guard !window.subviews.contains(where: { $0 is BlockingActivityIndicator }) else {
                return
            }
            
            let activityIndicator = BlockingActivityIndicator()
            activityIndicator.setupMessage(message: message)
            activityIndicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            activityIndicator.frame = window.bounds
            if isClearBackground {
                activityIndicator.backgroundColor = .clear
            }
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
        UIView.transition(
            with: view,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: {
                view.addSubview(activityIndicator)
            }
        )
        
    }
    
    @objc public static func dismiss() {
        
        if let window = keyWindow {
            window.subviews.filter { $0 is BlockingActivityIndicator }.forEach { view in
                view.removeFromSuperview()
            }
        }
        
    }
    
    @objc public static func dismiss(from view: UIView) {
        
        view.subviews.filter { $0 is BlockingActivityIndicator }.forEach { obj in
            obj.removeFromSuperview()
        }
        
    }
    
}

final class BlockingActivityIndicator: UIView {
    
    private let loaderColor = UIColor(red: 135.0 / 255.0, green: 84.0 / 255.0, blue: 161.0 / 255.0, alpha: 1.0)
    private let containerView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 12
        view.alignment = .fill
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let messageLabel: UILabel = {
        let view = UILabel()
        view.fontTextStyle = .smilesHeadline5
        view.textAlignment = .center
        view.numberOfLines = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let activityIndicator: NVActivityIndicatorView
    
    override init(frame: CGRect) {
        self.activityIndicator = NVActivityIndicatorView(
            frame: CGRect(
                origin: .zero,
                size: CGSize(width: 60, height: 60)
            )
        )
        activityIndicator.type = .ballClipRotate
        activityIndicator.color = loaderColor
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.textColor = loaderColor
        super.init(frame: frame)
        backgroundColor = UIColor.white.withAlphaComponent(0.75)
        setupViews()
        
    }
    
    private func setupViews() {
        
        containerView.addArrangedSubview(activityIndicator)
        containerView.addArrangedSubview(messageLabel)
        addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.2)
        ])
        
    }
    
    func setupMessage(message: String?) {
//        if let message {
//            messageLabel.text = message
//        } else {
            messageLabel.isHidden = true
//        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
