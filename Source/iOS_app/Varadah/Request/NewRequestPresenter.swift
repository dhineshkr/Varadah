//
//  Presenter.swift
//  ViperDemo
//
//  Created by Dhineshkumar_r on 10/18/16.
//  Copyright © 2016 Dhineshkumar_r. All rights reserved.
//

import ObjectMapper
import Foundation
import UIKit

class NewRequestViewModel {
    var photo:UIImage?
    var treesCount:String
    var trucksRequired:String
    var location:String = ""
    var sponsorName:String = ""
    var sponsorCell:String = ""
    
    init(treesCount: String, trucksRequired: String) {
        self.trucksRequired = trucksRequired
        self.treesCount = treesCount
    }
}

class NewRequestPresenter : NSObject, InteractorDelegate {
    
    private var requestVM: NewRequestViewModel
    private var interactor: NewRequestInteractor!
    unowned var viewHandler: PresenterDelegate
    
    init(handler: PresenterDelegate) {
        self.requestVM = NewRequestViewModel(treesCount: "", trucksRequired: "")
        self.viewHandler = handler
        super.init()
        self.interactor = NewRequestInteractor(handler: self)
    }
    
    func initModels() {
    }
    
    func addNewRequest(vm: NewRequestViewModel) {
        self.interactor.addNewRequest(vm)
    }
        
    func updateViewData(model: RequestModel) {
//        let areaList = model.areas.joinWithSeparator(", ")
//        self.homeVM.topAreasText = String(format: "Top Areas: %@", areaList)
//        self.homeVM.totalRequestText = String(format: "Total Request:%d", model.total)
//        self.homeVM.requestProcessedText = String(format: "Funded Request:%d", model.funded)
//        self.homeVM.progress = Double((Double(model.funded) / Double(model.total))*100.0)
//        if self.homeVM.progress < 55 {
//            self.homeVM.progressColor = Utill.getColor(248, g: 8, b: 8)
//        }
    }
    
    func responseOnSuccess(response:Mappable) {
        if let model = response as? RequestModel {
            self.viewHandler.updateView(model)
        }
    }
    
    func responseOnFailure(error: ErrorType?) {
        self.viewHandler.updateError(error)
    }
    
}


