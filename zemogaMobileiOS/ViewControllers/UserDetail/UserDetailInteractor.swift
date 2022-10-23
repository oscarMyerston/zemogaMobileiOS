//
//  UserDetailInteractor.swift
//  pruebaZemoga
//
//  Created by Oscar David Myerston Vega on 17/10/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol IUserDetailInteractor: AnyObject {
	var parameters: [String: Any]? { get set }
    func getInfoUser()
}

class UserDetailInteractor: IUserDetailInteractor {
    var presenter: IUserDetailPresenter?
    var manager: IUserDetailManager?
    var parameters: [String: Any]?

    init(presenter: IUserDetailPresenter, manager: IUserDetailManager) {
    	self.presenter = presenter
    	self.manager = manager
    }

    func getInfoUser() {
        guard let data = parameters?["userDetail"] as? UserDetailModel.User else { return }
        self.presenter?.setDataUser(data: data)
    }

}
