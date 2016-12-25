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

class HomeViewModel {
    var totalRequestText:String
    var requestProcessedText:String
    var topAreasText:String
    var progressColor: UIColor
    var progress: Double
    
    init(total: String, funded: String, areas: String,
         progressColor: UIColor, progress: Double) {
        self.totalRequestText = total
        self.requestProcessedText = funded
        self.topAreasText = areas
        self.progressColor = progressColor
        self.progress = progress
    }
}

class HomePresenter : NSObject, InteractorDelegate {
    
    private var homeVM: HomeViewModel
    private var interactor: HomeInteractor!
    unowned var viewHandler: PresenterDelegate
    
    init(handler: PresenterDelegate) {
        self.homeVM = HomeViewModel(total: "", funded: "", areas: "",
                    progressColor: Utill.getColor(108, g: 108, b: 108),
                    progress: 0)
        self.viewHandler = handler
        super.init()
        self.interactor = HomeInteractor(handler: self)
    }
    
    func initModels() {
        self.interactor.getDashboardData()
    }
        
    func updateViewData(model: HomeModel) {
        let areaList = model.areas.joinWithSeparator(", ")
        self.homeVM.topAreasText = String(format: "Top Areas: %@", areaList)
        self.homeVM.totalRequestText = String(format: "Total Request:%d", model.total)
        self.homeVM.requestProcessedText = String(format: "Funded Request:%d", model.funded)
        self.homeVM.progress = Double((Double(model.funded) / Double(model.total))*100.0)
        if self.homeVM.progress < 55 {
            self.homeVM.progressColor = Utill.getColor(248, g: 8, b: 8)
        }
    }
    
    func responseOnSuccess(response:Mappable) {
        if let model = response as? HomeModel {
            self.updateViewData(model)
        }
        self.viewHandler.updateView(self.homeVM)
    }
    
    func responseOnFailure(error: ErrorType?) {
        self.viewHandler.updateError(error)
    }
    
}


