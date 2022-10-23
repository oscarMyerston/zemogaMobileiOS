//
//  Mapper.swift
//  AppZemoga
//
//  Created by Oscar David Myerston Vega on 8/10/22.
//

import Foundation
import RealmSwift

class Mapper {


    static func mapToPostLocal(_ post: HomeModel.HomePost) -> PostLocal {
        let postLocal = PostLocal()
        postLocal.userId = post.userId ?? 0
        postLocal.id = post.id ?? 0
        postLocal.title = post.title ?? ""
        postLocal.body = post.body ?? ""

        return postLocal
    }

    static func mapToPost(_ postLocal: PostLocal) -> HomeModel.HomePost {
        let post =  HomeModel.HomePost(
            userId: postLocal.userId,
            id: postLocal.id,
            title: postLocal.title,
            body: postLocal.body
        )
        return post
    }

    static func mapRealmResultSetToArray(_ postLocalList: Results<PostLocal>) -> [HomeModel.HomePost] {
        var postArray: [HomeModel.HomePost] = []
        for postLocal in postLocalList {
            postArray.append(mapToPost(postLocal))
        }
        return postArray
    }

}
