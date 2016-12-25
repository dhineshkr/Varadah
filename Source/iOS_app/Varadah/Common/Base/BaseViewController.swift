
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
    
    //MARK: AlertController
    func showAlert(title: String = ViewControllerConstants.kAppTitle, message: String,
                    okButtonTitle: String = ViewControllerConstants.kAppOkButton,
                    cancelButtonTitle: String? = nil, tag: Int = 0) {
        dispatch_async(dispatch_get_main_queue(),{
            let alertMessage = UIAlertController(title: title, message: message,
                preferredStyle: .Alert)
            let okAction = UIAlertAction(title: okButtonTitle,
                style: UIAlertActionStyle.Default) { UIAlertAction in
                self.processAlertActionForOK(tag)
            }
            alertMessage.addAction(okAction)
            if cancelButtonTitle != nil {
                let cancelAction = UIAlertAction(title: cancelButtonTitle,
                    style: UIAlertActionStyle.Default) { UIAlertAction in
                    self.processAlertActionForCancel()
                }
                alertMessage.addAction(cancelAction)
            }
            self.presentViewController(alertMessage, animated: true, completion: nil)
        })
    }
    
    //MARK: AlertView Custom Delegate Mehtod
    func processAlertActionForOK(tag: Int, details: AnyObject? = nil) {
        //Override if AlertViewController to be handled.
    }
    
    func processAlertActionForCancel() {
        //Override if AlertViewController to be handled.
    }
    
    
}
