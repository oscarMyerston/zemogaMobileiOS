//
//  PostDetailModel.swift
//  pruebaZemoga
//
//  Created by Oscar David Myerston Vega on 17/10/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

struct Comment: Codable {
    var postId: Int?
    var id: Int?
    var name: String?
    var email: String?
    var body: String? 
}
