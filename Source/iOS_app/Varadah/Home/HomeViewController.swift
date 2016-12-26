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
    @IBOutlet weak var fundedRequestLabel: UILabel!
    @IBOutlet weak var topAreasLabel: UILabel!
    @IBOutlet weak var progressView: CircleProgressView!
    @IBOutlet weak var fundedRequestPercent: UILabel!
    @IBOutlet weak var rightview: UIView!
    
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
        self.rightview.hidden = true
        self.showSpinner()
    }
    
    func refreshViews() {
        if self.rightview.hidden {
            self.rightview.hidden = false
        }
        self.hideSpinner()
    }

    //PresenterDelegate Implementation
    func updateView(response: AnyObject?) {
        self.refreshViews()
        if let hvm = response as? HomeViewModel {
            self.topAreasLabel.text = hvm.topAreasText
            self.totalRequestLabel.text = hvm.totalRequestText
            self.fundedRequestLabel.text = hvm.requestProcessedText
            self.fundedRequestPercent.text = String(format:"%.0f%%", hvm.progress)
            self.progressView.progress = hvm.progress
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

