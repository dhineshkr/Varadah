//
//  Interactor.swift
//  ViperDemo
//
//  Created by Dhineshkumar_r on 10/18/16.
//  Copyright © 2016 Dhineshkumar_r. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

class RequestModel : Mappable {
    var _id:String = ""
    var location:String = ""
    var sponsorName:String = ""
    var sponsorCell:String = ""
    var treesCount:String = ""
    var trucksRequired:String = ""
    
    func mapping(map: Map) {
        _id <- map["_id"]
        location <- map["location"]
        sponsorName <- map["sponsorName"]
        sponsorCell <- map["sponsorCell"]
        treesCount <- map["treesCount"]
        trucksRequired <- map["trucksRequired"]
    }
    
    required init?(_ map: Map) {
        //JSON validation comes here prior to object creation
    }
}

class NewRequestInteractor {
    
    unowned var resultHandler: InteractorDelegate
    
    init(handler: InteractorDelegate) {
        self.resultHandler = handler
    }
    
    func addNewRequest(vm: NewRequestViewModel) {
        let URL = "https://baas.kinvey.com/appdata/kid_SJrDLHTVe/Request"
        var parameters: [String: AnyObject] = [
            "treesCount": vm.treesCount,
            "trucksRequired": vm.trucksRequired,
            "location": vm.location]
        if vm.sponsorName.characters.count > 0 && vm.sponsorCell.characters.count > 0 {
            parameters["sponsorName"] = vm.sponsorName
            parameters["sponsorCell"] = vm.sponsorCell
        }
        Alamofire.request(.POST, URL, parameters:parameters, encoding: .JSON,
            headers: Interactor().defaultHeaders).responseObject { (
            response: Response<RequestModel, NSError>) in
            
            if let homeData = response.result.value {
                self.resultHandler.responseOnSuccess(homeData)
            } else {
                self.resultHandler.responseOnFailure(response.result.error)
            }
        }
    }
    
}