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

public struct Interactor {
    let defaultHeaders: [String:String] = [
        "X-Kinvey-API-Version": "3",
        "Authorization": "Basic a2lkX1NKckRMSFRWZTpjZDhmNGY3NGQ4MTg0OGE1OGFlNjkyMjQ2YmUxYmI4NQ==",
        "Content-Type": "application/json"
    ]
}
