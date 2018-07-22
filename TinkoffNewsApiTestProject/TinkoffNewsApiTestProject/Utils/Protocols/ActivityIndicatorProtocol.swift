//
//  ActivityIndicatorProtocol.swift
//  TinkoffNewsApiTestProject
//
//  Created by Александр Кузяев on 22.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import Foundation
import UIKit

protocol ActivityIndicatorProtocol where Self: UIViewController {
    weak var activityIndicator: UIActivityIndicatorView! { get }
    func showActivityIndicatior(show: Bool)
}

extension ActivityIndicatorProtocol {
    
    func showActivityIndicatior(show: Bool) {
        if activityIndicator != nil {
            if show {
                activityIndicator.startAnimating()
            } else {
                activityIndicator.stopAnimating()
            }
        }
    }
    
}
