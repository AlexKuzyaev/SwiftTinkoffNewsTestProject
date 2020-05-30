//
//  NewsDetailViewController.swift
//  TinkoffNewsApiTestProject
//
//  Created by Александр Кузяев on 21.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import UIKit

final class NewsDetailViewController: UIViewController {

    // MARK: - IBOutlets

    var output: NewsDetailViewOutput?

    // MARK: - IBOutlets
    
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - UIViewController

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textView.setContentOffset(CGPoint.zero, animated: false)
    }
}

// MARK: - Public Methods

extension NewsDetailViewController: NewsDetailViewInput {

    func updateData(attributedString: NSAttributedString) {
        textView.attributedText = attributedString
    }
}


