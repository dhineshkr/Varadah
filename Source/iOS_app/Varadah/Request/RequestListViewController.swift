//
//  RequestListViewController.swift
//  Varadah
//
//  Created by Dhineshkumar_r on 12/26/16.
//  Copyright © 2016 Dhineshkumar_r. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

class RequestListViewController: BaseViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var listFunded = false
    private var requestModel: [RequestModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initiViews()
        self.getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initiViews() {
        self.showSpinner()
        self.getData()
    }
    
    func refreshViews() {
        self.tableView.reloadData()
        self.hideSpinner()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func getData() {
        let URL = "https://baas.kinvey.com/appdata/kid_SJrDLHTVe/Request"
        
        Alamofire.request(.GET, URL, headers: Interactor().defaultHeaders
            ).responseArray { (response: Response<[RequestModel], NSError>) in
                if let homeData = response.result.value {
                    self.requestModel = self.filterData(homeData, filterFunded: self.listFunded)
                    self.refreshViews()
                } else {
                    self.showAlert(message: "Unable to process the Request")
                }
        }
    }
    
    func filterData(rm: [RequestModel], filterFunded: Bool) -> [RequestModel] {
        var filtered: [RequestModel] = []
        for req in rm {
            if filterFunded {
                if req.sponsorName.characters.count > 0 && req.sponsorCell.characters.count > 0 {
                    filtered.append(req)
                }
            } else {
                if req.sponsorName.characters.count <= 0 && req.sponsorCell.characters.count <= 0 {
                    filtered.append(req)
                }
            }
        }
        return filtered
    }
    
    //Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.requestModel.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath
        ) -> UITableViewCell {
        let rm = self.requestModel[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(
            "request_cell_left_allign")as? RequestCellLeftAllign
        cell?.initCellWithData(rm)
        return cell!
    }

    @IBAction func dismissViewAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
