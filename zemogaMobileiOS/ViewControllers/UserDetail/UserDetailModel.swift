//
//  UserDetailModel.swift
//  pruebaZemoga
//
//  Created by Oscar David Myerston Vega on 17/10/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

struct UserDetailModel {

    struct User: Codable {
        var id: Int?
        var name: String?
        var email: String?
        var username: String?
        var address: Address?
        var phone: String?
        var website: String?
        var company: Company?
    }

    struct Address: Codable {
        var street: String?
        var suite: String?
        var city: String?
        var zipcode: String?
    }

    struct Company: Codable {
        var name: String?
        var catchPhrase: String?
        var bs: String?
    }
}
