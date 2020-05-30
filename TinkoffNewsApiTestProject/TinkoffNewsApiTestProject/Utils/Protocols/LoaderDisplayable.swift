//
//  LoaderDisplayable.swift
//  TinkoffNewsApiTestProject
//
//  Created by Александр Кузяев on 22.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import Foundation
import UIKit

protocol LoaderDisplayable: class {

    // MARK: - Properties

    var activityIndicator: UIActivityIndicatorView! { get }

    // MARK: - Public Methods

    func showActivityIndicatior(show: Bool)
}

// MARK: - Public Methods Realization

extension LoaderDisplayable {

    func showActivityIndicatior(show: Bool) {
        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}
