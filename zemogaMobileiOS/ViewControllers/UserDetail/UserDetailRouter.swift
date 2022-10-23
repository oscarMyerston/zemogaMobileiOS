//
//  UserDetailRouter.swift
//  pruebaZemoga
//
//  Created by Oscar David Myerston Vega on 17/10/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol IUserDetailRouter: AnyObject {
	// do someting...
}

class UserDetailRouter: IUserDetailRouter {	
	weak var view: UserDetailViewController?
	
	init(view: UserDetailViewController?) {
		self.view = view
	}
}
