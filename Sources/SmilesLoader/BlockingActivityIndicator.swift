//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 12/01/2024.
//

import UIKit
import NVActivityIndicatorView
import SmilesFontsManager

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
        backgroundColor = UIColor.white.withAlphaComponent(0.8)
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
