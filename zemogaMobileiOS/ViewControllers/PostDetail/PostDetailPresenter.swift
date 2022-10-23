//
//  PostDetailPresenter.swift
//  pruebaZemoga
//
//  Created by Oscar David Myerston Vega on 17/10/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol IPostDetailPresenter: AnyObject {
    func showError(message: String)
    func loadingHide()
    func comments(parameters: [Comment])
    func setUser(parameters: UserDetailModel.User)

}

class PostDetailPresenter: IPostDetailPresenter {	
	weak var view: IPostDetailViewController?
	
	init(view: IPostDetailViewController?) {
		self.view = view
	}

    func showError(message: String) {
        self.view?.router?.showError(message: message)
    }

    func loadingHide() {
        self.view?.loadingHide()
    }

    func comments(parameters: [Comment]) {
        self.view?.comments(parameters: parameters)
    }

    func setUser(parameters: UserDetailModel.User) {
        self.view?.setUser(parameters: parameters)
    }

}
