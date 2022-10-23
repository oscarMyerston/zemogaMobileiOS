//
//  PostDetailRouter.swift
//  pruebaZemoga
//
//  Created by Oscar David Myerston Vega on 17/10/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol IPostDetailRouter: AnyObject {
    func showError(message: String)

}

class PostDetailRouter: IPostDetailRouter {	
	weak var view: PostDetailViewController?
	
	init(view: PostDetailViewController?) {
		self.view = view
	}

    func showError(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            @unknown default:
                fatalError()
            }
        }))
        self.view?.present(alert, animated: true, completion: nil)
    }
}
