//
//  NewsDetailViewController.swift
//  TinkoffNewsApiTestProject
//
//  Created by Александр Кузяев on 21.07.18.
//  Copyright © 2018 Alexandr Kuzyaev. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController, ActivityIndicatorProtocol {
    
    weak var presenter: NewsDetailViewControllerPresenter!
    
    @IBOutlet fileprivate weak var textView: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    class func instance() -> NewsDetailViewController {
        return Storyboard.main.instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textView.setContentOffset(CGPoint.zero, animated: false)
    }
}

extension NewsDetailViewController {

    func updateData(attributedString: NSAttributedString) {
        textView.attributedText = attributedString
    }
    
    func showError(error: String) {
        showAlert(alertTitle: "Error", message: error)
    }
}

