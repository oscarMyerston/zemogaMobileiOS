//
//  HomeInteractor.swift
//  pruebaZemoga
//
//  Created by Oscar David Myerston Vega on 17/10/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit
import RealmSwift

protocol IHomeInteractor: AnyObject {
	var parameters: [String: Any]? { get set }
    func loadPost()
    func getPosts()
    func removePost(post: HomeModel.HomePost)
    func removePosts(posts: [HomeModel.HomePost])
}

class HomeInteractor: IHomeInteractor {

    var presenter: IHomePresenter?
    var manager: IHomeManager?
    var parameters: [String: Any]?

    init(presenter: IHomePresenter, manager: IHomeManager) {
    	self.presenter = presenter
    	self.manager = manager
    }

    func loadPost() {
        manager?.fetchPostsFromLocalDB() { response in
            switch response {
            case .success(let result):
                if let data: [HomeModel.HomePost] = result as? [HomeModel.HomePost] {
                    if !data.isEmpty {
                        self.presenter?.posts(parameters: data)
                    } else {
                        self.getPosts()
                    }
                }
            case .failure(let error):
                switch error {
                case .internalError:
                    debugPrint("error: \(error)")
                    self.presenter?.showError(message: "A error ocurred, try later")
                case .serverError:
                    self.presenter?.showError(message: "Can't connect with server, please check internet connection.")
                    debugPrint("error: \(error)")
                case .requestError:
                    self.presenter?.showError(message: "Please contact with admin")
                    debugPrint("error: \(error)")
                }
            }
            self.presenter?.loadingHide()
        }

    }

    func getPosts() {
        self.manager?.getPosts { response in
            debugPrint("response: \(response)")
            switch response {
            case .success(let result):
                if let data: [HomeModel.HomePost] = result as? [HomeModel.HomePost] {
                    if !data.isEmpty {
                        self.presenter?.posts(parameters: data)
                        DispatchQueue.main.async {
                          _ = data.map({
                                self.addPostsToDB(with: $0)
                            })
                        }
                    }
                    debugPrint("data: \(data)")
                }
            case .failure(let error):
                switch error {
                case .internalError:
                    debugPrint("error: \(error)")
                    self.presenter?.showError(message: "A error ocurred, try later")
                case .serverError:
                    self.presenter?.showError(message: "Can't connect with server, please check internet connection.")
                    debugPrint("error: \(error)")
                case .requestError:
                    self.presenter?.showError(message: "Please contact with admin")
                    debugPrint("error: \(error)")
                }
            }
            self.presenter?.loadingHide()
        }
    }

    func removePosts(posts: [HomeModel.HomePost]) {
        // presenter?.deleteInfo(to: indexPath)
        manager?.removeAllPosts(posts: posts) { response in
            debugPrint("Success removeAllPosts")
        }

    }

    func removePost(post: HomeModel.HomePost) {
        manager?.removePost(post: post) { response in
            debugPrint("Success removeAllPosts")
        }
    }

    func addPostsToDB(with post: HomeModel.HomePost) {
        manager?.addPosts(posts: post) { response in
            debugPrint("Success addPosts")
        }
    }
}
