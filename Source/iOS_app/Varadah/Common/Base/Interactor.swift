//
//  Interactor.swift
//  ViperDemo
//
//  Created by Dhineshkumar_r on 10/18/16.
//  Copyright © 2016 Dhineshkumar_r. All rights reserved.
//

import Foundation
import ObjectMapper

protocol InteractorDelegate : class {
    func responseOnSuccess(response:Mappable)
    func responseOnFailure(error: ErrorType?)
}

