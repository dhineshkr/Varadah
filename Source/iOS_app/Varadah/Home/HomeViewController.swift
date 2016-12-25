//
//  ViewController.swift
//  Varadah
//
//  Created by Dhineshkumar_r on 12/24/16.
//  Copyright © 2016 Dhineshkumar_r. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController, PresenterDelegate {

    private var presenter: HomePresenter!

    @IBOutlet weak var totalRequestLabel: UILabel!
    @IBOutlet weak var processedRequestLabel: UILabel!
    @IBOutlet weak var topAreasLabel: UILabel!
    @IBOutlet weak var progressView: CircleProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.presenter = HomePresenter(handler: self)
        self.initiViews()
        self.presenter.initModels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initiViews() {
//        self.view.hidden = true
        self.showSpinner()
    }
    
    func refreshViews() {
        if self.view.hidden {
            self.view.hidden = false
        }
        self.hideSpinner()
    }

    //PresenterDelegate Implementation
    func updateView(response: AnyObject?) {
        self.refreshViews()
        if let hvm = response as? HomeViewModel {
            self.topAreasLabel.text = hvm.topAreasText
            self.totalRequestLabel.text = hvm.totalRequestText
            self.processedRequestLabel.text = hvm.requestProcessedText
            self.progressView.progress = hvm.progress
//            self.progressView.progress = Double(40)
            self.progressView.trackFillColor = hvm.progressColor
            self.progressView.updateUI()
        }
        //refresh the whole view
    }
    
    func updateError(error: ErrorType?) {
        self.refreshViews()
        print(error)
    }

}

