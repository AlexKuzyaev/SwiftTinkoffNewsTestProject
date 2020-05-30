//
//  ErrorDisplayable.swift
//  TinkoffNewsApiTestProject
//
//  Created by Александр Кузяев on 30.05.2020.
//  Copyright © 2020 Alexandr Kuzyaev. All rights reserved.
//

import Foundation
import UIKit

protocol ErrorDisplayable: class {

    // MARK: - Public Methods

    func showError(error: String)
}

// MARK: - Public Methods Realization

extension ErrorDisplayable where Self: UIViewController {

    func showError(error: String) {
        showAlert(alertTitle: Strings.error, message: error)
    }
}
