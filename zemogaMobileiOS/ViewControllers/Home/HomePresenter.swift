//
//  HomePresenter.swift
//  pruebaZemoga
//
//  Created by Oscar David Myerston Vega on 17/10/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol IHomePresenter: AnyObject {
    func posts(parameters: [HomeModel.HomePost])
    func showError(message: String)
    func loadingHide()
    func deleteInfo(to: IndexPath)
}

class HomePresenter: IHomePresenter {	
	weak var view: IHomeViewController?
	
	init(view: IHomeViewController?) {
		self.view = view
	}

    func posts(parameters: [HomeModel.HomePost]) {
        self.view?.posts(parameters: parameters)
    }

    func showError(message: String) {
        self.view?.router?.showError(message: message)
    }

    func loadingHide() {
        self.view?.loadingHide()
    }

    func deleteInfo(to: IndexPath) {
        self.view?.deleteInfo(to: to)
    }

}
