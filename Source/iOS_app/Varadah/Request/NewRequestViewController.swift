//
//  ViewController.swift
//  Varadah
//
//  Created by Dhineshkumar_r on 12/24/16.
//  Copyright © 2016 Dhineshkumar_r. All rights reserved.
//

import UIKit

class NewRequestViewController: BaseViewController, PresenterDelegate,
    UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    private var presenter: NewRequestPresenter!
    var imagePicker = UIImagePickerController()
//    lazy var imagePicker: UIImagePickerController = {
//        [unowned self] in
//       let ret = UIImagePickerController()
//        ret.delegate = self
//        return ret
//    }()

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var treesCountText: UITextField!
    @IBOutlet weak var trucksRequiredText: UITextField!
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var cellNo: UITextField!
    @IBOutlet weak var selfFundedSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.presenter = NewRequestPresenter(handler: self)
        self.initiViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initiViews() {
        self.selfFundedSwitch.on = false
        self.name.enabled = false
        self.cellNo.enabled = false
        imagePicker.delegate = self
//        self.showSpinner()
    }
    
    func refreshViews() {
        self.hideSpinner()
    }

    //PresenterDelegate Implementation
    func updateView(response: AnyObject?) {
        self.refreshViews()
        if let vm = response as? NewRequestViewModel {
        }
        //refresh the whole view
        if let addedModel = response as? RequestModel {
            self.showAlert(message: "New Request Added Succesfully!!!")
        }
    }
    
    func updateError(error: ErrorType?) {
        self.refreshViews()
        print(error)
    }
    
    //Image picker delegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.photo.image = chosenImage
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    @IBAction func addPhotoAction(sender: AnyObject) {
        self.imagePicker.allowsEditing = false
        self.imagePicker.sourceType = .PhotoLibrary
        self.presentViewController(self.imagePicker, animated: true, completion: nil)
    }

    @IBAction func addRequestAction(sender: AnyObject) {
        var newVM = NewRequestViewModel(treesCount: "", trucksRequired: "")
        if let count = self.treesCountText.text {
            newVM.treesCount = count
        }
        if let trucks = self.trucksRequiredText.text {
            newVM.trucksRequired = trucks
        }
        if let location = self.locationText.text {
            newVM.location = location
        }
        if self.selfFundedSwitch.on {
            if let name = self.name.text {
                newVM.sponsorName = name
            }
            if let cell = self.cellNo.text {
                newVM.sponsorCell = cell
            }
        }
        self.showSpinner()
        self.presenter.addNewRequest(newVM)
    }
    
    @IBAction func selfFundedSwitchAction(sender: AnyObject) {
        self.name.enabled = self.selfFundedSwitch.on
        self.cellNo.enabled = self.selfFundedSwitch.on
    }

    @IBAction func dismissRequestAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

