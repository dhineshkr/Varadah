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

protocol PresenterDelegate : class {
    func updateView(viewData: AnyObject?)
    func updateError(errorData: ErrorType?)
}
