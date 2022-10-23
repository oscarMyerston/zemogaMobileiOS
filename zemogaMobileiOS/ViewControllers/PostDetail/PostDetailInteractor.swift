//
//  PostDetailInteractor.swift
//  pruebaZemoga
//
//  Created by Oscar David Myerston Vega on 17/10/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol IPostDetailInteractor: AnyObject {
    var parameters: [String: Any]? { get set }
    func getCommentsForPost()
    func getPostSelected() -> HomeModel.HomePost
    func getUser()

}

class PostDetailInteractor: IPostDetailInteractor {
    var presenter: IPostDetailPresenter?
    var manager: IPostDetailManager?
    var parameters: [String: Any]?

    init(presenter: IPostDetailPresenter, manager: IPostDetailManager) {
        self.presenter = presenter
        self.manager = manager
    }

    func getCommentsForPost() {
        guard let post = parameters?["detail"] as? HomeModel.HomePost else { return }
        getCommentsForPost(postId: post.id!)
    }

    func getPostSelected() -> HomeModel.HomePost {
        guard let post = parameters?["detail"] as? HomeModel.HomePost else { return HomeModel.HomePost(userId: 0, id: 0, title: "", body: "") }
        return post
    }

    func getCommentsForPost(postId: Int) {
        manager?.getCommentsForPost(postId: postId) { response in
            debugPrint("response: \(response)")
            switch response {
            case .success(let result):
                if let data: [Comment] = result as? [Comment] {
                    if !data.isEmpty {
                        DispatchQueue.main.async {
                            self.presenter?.comments(parameters: data)
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

    func getUser() {
        let post = getPostSelected()
        manager?.getUser(id: post.userId!) { response in
            switch response {
                case .success(let result):
                    if let data: UserDetailModel.User = result as? UserDetailModel.User {
                            DispatchQueue.main.async {
                                self.presenter?.setUser(parameters: data)
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

}
