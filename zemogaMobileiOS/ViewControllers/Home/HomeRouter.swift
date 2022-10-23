//
//  HomeRouter.swift
//  pruebaZemoga
//
//  Created by Oscar David Myerston Vega on 17/10/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol IHomeRouter: AnyObject {
    func showError(message: String)
    func navigationToPostDetail(post: HomeModel.HomePost)

}

class HomeRouter: IHomeRouter {	
	weak var view: HomeViewController?
	
	init(view: HomeViewController?) {
		self.view = view
	}

    func navigationToPostDetail(post: HomeModel.HomePost) {
        let postVC = PostDetailConfiguration.setup(parameters: ["detail": post])
        self.view?.navigationController?.pushViewController(postVC, animated: true)
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

    func showNotNetwork() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Alert", message: "Oops, Internet connection failed", preferredStyle: .alert)
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
}
