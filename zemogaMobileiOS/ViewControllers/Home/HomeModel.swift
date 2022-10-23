//
//  HomeModel.swift
//  pruebaZemoga
//
//  Created by Oscar David Myerston Vega on 17/10/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit
import RealmSwift

struct HomeModel {

    struct Constants {
        // MARK: connection
        static let networkProtocol: String = "https://"
        static let domain: String = "jsonplaceholder.typicode.com"
        static let urlSecure: String = Constants.networkProtocol + Constants.domain
        static let emptyListMessage = "List is empty"

    }

    struct HomePost: Codable {
        let userId: Int?
        let id: Int?
        let title: String?
        let body: String?
        var read: Bool?
        var isFav: Bool?

    }
}

enum PublicationEndpoints: String {
    case getInfo = "/posts"

}


class PostLocal: Object {
    @objc dynamic var userId: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var body: String = ""
    @objc dynamic var read: Bool = true
    @objc dynamic var isFav: Bool = false
}

typealias ModelCompletion = ( (_ response: Result<Any, TypeError>) -> Void )

enum TypeError: Error {
    case internalError
    case serverError
    case requestError
}
