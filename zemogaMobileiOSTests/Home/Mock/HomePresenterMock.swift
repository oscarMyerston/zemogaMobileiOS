//
//  HomePresenterMock.swift
//  pruebaZemogaTests
//
//  Created by Oscar David Myerston Vega on 22/10/22.
//

import Foundation
@testable import zemogaMobileiOS

class HomePresenterMock: IHomePresenter {
    
    var checkPosts = false
    var checkMessage = false
    var checkLoadingHide = false
    var checkDeleteInfo = false

    func posts(parameters: [zemogaMobileiOS.HomeModel.HomePost]) {
        if !parameters.isEmpty {
            checkPosts = true
        }
    }

    func showError(message: String) {
        if !message.isEmpty {
            checkMessage = true
        }
    }

    func loadingHide() {
        checkLoadingHide = true
    }

    func deleteInfo(to: IndexPath) {
        checkDeleteInfo = true
    }


}
