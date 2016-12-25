
//
//  BaseViewController.swift
//  ViperDemo
//
//  Created by Dhineshkumar_r on 10/18/16.
//  Copyright © 2016 Dhineshkumar_r. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    override func loadView() {
        super.loadView()
        self.automaticallyAdjustsScrollViewInsets = false
        loadingView.frame = CGRectMake(0, 0, 40, 40)
        loadingView.center = self.view.center
        loadingView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha:0.7)
        
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 8
        
        activityIndicator.transform = CGAffineTransformMakeScale(0.8, 0.8)
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        activityIndicator.center = CGPointMake(loadingView.frame.size.width / 2, loadingView.frame.size.height / 2);
        loadingView.addSubview(activityIndicator)
        loadingView.hidden = true
        self.view.addSubview(loadingView)
      
    }
    
    func showSpinner() {
        loadingView.hidden = false
        self.view.bringSubviewToFront(self.activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func hideSpinner() {
        loadingView.hidden = true
        activityIndicator.stopAnimating()
    }
    
}
