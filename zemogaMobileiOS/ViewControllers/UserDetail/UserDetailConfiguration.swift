//
//  UserDetailConfiguration.swift
//  pruebaZemoga
//
//  Created by Oscar David Myerston Vega on 17/10/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import Foundation
import UIKit

class UserDetailConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = UserDetailViewController()
        let router = UserDetailRouter(view: controller)
        let presenter = UserDetailPresenter(view: controller)
        let manager = UserDetailManager()
        let interactor = UserDetailInteractor(presenter: presenter, manager: manager)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}
