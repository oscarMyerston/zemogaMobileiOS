//
//  PostDetailConfiguration.swift
//  pruebaZemoga
//
//  Created by Oscar David Myerston Vega on 17/10/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import Foundation
import UIKit

class PostDetailConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = PostDetailViewController()
        let router = PostDetailRouter(view: controller)
        let presenter = PostDetailPresenter(view: controller)
        let manager = PostDetailManager()
        let interactor = PostDetailInteractor(presenter: presenter, manager: manager)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}
