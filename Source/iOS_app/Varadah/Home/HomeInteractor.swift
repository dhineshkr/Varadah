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

class HomeModel : Mappable {
    var total:Int = 0
    var funded:Int = 0
    var areas:[String] = []
    
    func mapping(map: Map) {
        total <- map["total"]
        funded <- map["funded"]
        areas <- map["areas"]
    }

    required init?(_ map: Map) {
        //JSON validation comes here prior to object creation
    }
}

class HomeInteractor {
    
    unowned var resultHandler: InteractorDelegate
    
    init(handler: InteractorDelegate) {
        self.resultHandler = handler
    }
    
    func getDashboardData() {
        let URL = "https://demo6377508.mockable.io/varadah/dashboard"
        Alamofire.request(.POST, URL).responseObject { (
            response: Response<HomeModel, NSError>) in
            
            if let homeData = response.result.value {
                self.resultHandler.responseOnSuccess(homeData)
            } else {
                self.resultHandler.responseOnFailure(response.result.error)
            }
        }
    }
    
}