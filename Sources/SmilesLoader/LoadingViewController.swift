//
//  LoadingViewController.swift
//  
//
//  Created by Abdul Rehman Amjad on 12/01/2024.
//

import UIKit
import SmilesUtilities

class LoadingViewController: UIViewController {

    private var message: String?
    private var isClearBackground: Bool = false
    
    init(message: String? = nil, isClearBackground: Bool = false) {
        self.message = message
        self.isClearBackground = isClearBackground
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupLoader()
    }
    
    private func setupLoader() {
        
        let activityIndicator = BlockingActivityIndicator()
        activityIndicator.setupMessage(message: message)
        activityIndicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        activityIndicator.frame = view.bounds
        if isClearBackground {
            activityIndicator.backgroundColor = .clear
        }
        view.addSubview(activityIndicator)
        
    }

}
