//
//  HomeManager.swift
//  pruebaZemoga
//
//  Created by Oscar David Myerston Vega on 17/10/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import Foundation

protocol IHomeManager: AnyObject {
    func getPosts(completion: @escaping ModelCompletion)
    func fetchPostsFromLocalDB(completion: @escaping ModelCompletion)
    func addPosts(posts: HomeModel.HomePost, completion: @escaping ModelCompletion)
    func removeAllPosts(posts: [HomeModel.HomePost], completion: @escaping ModelCompletion)
    func removePost(post: HomeModel.HomePost, completion: @escaping ModelCompletion)
}

class HomeManager: IHomeManager {

    var realmManager: RealmManager

    init(realmManager: RealmManager = RealmManager()) {
        self.realmManager = realmManager
    }

    func fetchPostsFromLocalDB(completion: @escaping ModelCompletion) {
        completion(.success(realmManager.getAllPosts()))
    }

    func addPosts(posts: HomeModel.HomePost, completion: @escaping ModelCompletion) {
        let response = realmManager.addPost(posts)
        if response {
            completion(.success("Post added succesfully."))
        } else {
            completion(.success("Can`t add Post."))
        }
    }

    func getPosts(completion: @escaping ModelCompletion) {
        let endpoint = PublicationEndpoints.getInfo.rawValue
        Connection.sendRequest(endPoint: endpoint) { (response) in
            switch response {
            case .success(let result):
                do {
                    let posts = try JSONDecoder().decode( [HomeModel.HomePost].self, from: result)
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

    func removeAllPosts(posts: [HomeModel.HomePost], completion: @escaping ModelCompletion) {
        realmManager.removeAllPosts(posts: posts)
        completion(.success("Posts removed succesfully."))
        
    }

    func removePost(post: HomeModel.HomePost, completion: @escaping ModelCompletion) {
        realmManager.removePost(post: post)
        completion(.success("Posts removed succesfully."))

    }

}



