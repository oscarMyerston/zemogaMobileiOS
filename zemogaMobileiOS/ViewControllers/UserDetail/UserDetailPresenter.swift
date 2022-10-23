//
//  UserDetailPresenter.swift
//  pruebaZemoga
//
//  Created by Oscar David Myerston Vega on 17/10/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol IUserDetailPresenter: AnyObject {
    func setDataUser(data: UserDetailModel.User)
}

class UserDetailPresenter: IUserDetailPresenter {	
	weak var view: IUserDetailViewController?
	
	init(view: IUserDetailViewController?) {
		self.view = view
	}

    func setDataUser(data: UserDetailModel.User) {
        self.view?.setDataUser(data: data)
    }
}
