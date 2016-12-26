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
    
    init(total: Int, funded: Int) {
        self.total = total
        self.funded = funded
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
    
    func getTopAreas(areaCount: [String: Int]) -> [String] {
        var higher = 0
        var top: String = ""
        for (area, count) in areaCount {
            if count > higher {
                higher = count
                top = area
            }
        }
        return [top]
    }
    
    func getDabboardData(rm: [RequestModel]) -> HomeModel {
        let hm = HomeModel(total: 0, funded: 0)
        var topAreas: [String: Int] = [:]
        hm.total = rm.count
        var funded = 0
        for req in rm {
            if req.sponsorName.characters.count > 0 && req.sponsorCell.characters.count > 0 {
                funded = funded + 1
            }
            if req.location.characters.count > 0 {
                if let areaCount = topAreas[req.location] {
                    topAreas[req.location]  = areaCount + 1
                } else {
                    topAreas[req.location] = 1
                }
            }
            
        }
        hm.funded = funded
        hm.areas = self.getTopAreas(topAreas)
        return hm
    }
    
    func getDashboardData() {
        let URL = "https://baas.kinvey.com/appdata/kid_SJrDLHTVe/Request"
        
        Alamofire.request(.GET, URL, headers: Interactor().defaultHeaders
            ).responseArray { (response: Response<[RequestModel], NSError>) in
                if let homeData = response.result.value {
                    let model = self.getDabboardData(homeData)
                    self.resultHandler.responseOnSuccess(model)
                } else {
                    self.resultHandler.responseOnFailure(response.result.error)
                }
        }
    }
    
}