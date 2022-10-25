//
//  PostDetailManager.swift
//  pruebaZemoga
//
//  Created by Oscar David Myerston Vega on 17/10/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import Foundation

protocol IPostDetailManager: AnyObject {
    func getCommentsForPost(postId: Int, completion: @escaping ModelCompletion)
    func getUser(id: Int, completion: @escaping ModelCompletion)
    func updateFavorite(id: Int, isSelected: Bool)

}

class PostDetailManager: IPostDetailManager {

    private var realmManager: RealmManager

    init(realmManager: RealmManager = RealmManager()) {
        self.realmManager = realmManager
    }

    func getCommentsForPost(postId: Int, completion: @escaping ModelCompletion) {
        let endpoint = "/posts/\(postId)/comments"
        Connection.sendRequest(endPoint: endpoint) { (response) in
            switch response {
            case .success(let result):
                do {
                    let posts = try JSONDecoder().decode( [Comment].self, from: result)
                    completion(.success(posts as Any))
                } catch let error {
                    debugPrint("Error while parsing the data: \(error.localizedDescription)")
                    completion(.failure(.internalError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getUser(id: Int, completion: @escaping ModelCompletion) {
        let endpoint = "/users/\(id)"
        Connection.sendRequest(endPoint: endpoint) { (response) in
            switch response {
            case .success(let result):
                do {
                    let posts = try JSONDecoder().decode(UserDetailModel.User.self, from: result)
                    completion(.success(posts as Any))
                } catch let error {
                    debugPrint("Error while parsing the data: \(error.localizedDescription)")
                    completion(.failure(.internalError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func updateFavorite(id: Int, isSelected: Bool) {
        realmManager.updateObject(id, isSelected: isSelected)
    }
}
