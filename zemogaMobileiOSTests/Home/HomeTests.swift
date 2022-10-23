//
//  Home.swift
//  pruebaZemogaTests
//
//  Created by Oscar David Myerston Vega on 22/10/22.
//

import XCTest
@testable import zemogaMobileiOS

final class HomeTests: XCTestCase {

    let postsData = [
        HomeModel.HomePost(userId: 1, id: 1, title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit", body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"),
        HomeModel.HomePost(userId: 2, id: 2, title: "qui est esse", body: "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla"),
        HomeModel.HomePost(userId: 3, id: 3, title:  "ea molestias quasi exercitationem repellat qui ipsa sit aut", body: "et iusto sed quo iure\nvoluptatem occaecati omnis eligendi aut ad\nvoluptatem doloribus vel accusantium quis pariatur\nmolestiae porro eius odio et labore et velit aut"),
        HomeModel.HomePost(userId: 4, id: 4, title: "eum et est occaecati", body: "ullam et saepe reiciendis voluptatem adipisci\nsit amet autem assumenda provident rerum culpa\nquis hic commodi nesciunt rem tenetur doloremque ipsam iure\nquis sunt voluptatem rerum illo velit"),

    ]

    let post = HomeModel.HomePost(userId: 1, id: 1, title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit", body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")

    var interactor: IHomeInteractor?
    var presenterMock: HomePresenterMock?
    var managerMock: HomeManagerMock?

    override func setUpWithError() throws {
        presenterMock = HomePresenterMock()
        managerMock = HomeManagerMock()
        interactor = HomeInteractor(presenter: presenterMock!, manager: managerMock!)
    }

    override func tearDownWithError() throws {
        presenterMock = nil
        managerMock = nil
        interactor = nil
    }

    func test_getPosts_ResponseSuccess() {
        interactor?.getPosts()
        managerMock?.getPosts{ response in
            switch response {
            case .success(let result):
                if let data: [HomeModel.HomePost] = result as? [HomeModel.HomePost] {
                    if !data.isEmpty {
                        XCTAssertTrue(data.count > 0)
                        XCTAssertTrue(self.presenterMock!.checkPosts)
                        XCTAssertTrue(self.presenterMock!.checkLoadingHide)
                    }
                }
            case .failure(_):
                break
            }
        }
    }

    func test_getPosts_ResponsInternalError() {
        managerMock?.isInternalError = true
        interactor?.getPosts()
        managerMock?.getPosts{ response in
            switch response {
                case .success(_):
                    break
                case .failure(let error):
                    switch error {
                        case .internalError:
                            XCTAssertTrue(self.presenterMock!.checkMessage)
                        default:
                            break
                    }
            }
        }
    }

    func test_getPosts_ResponsServerError() {
        managerMock?.isServerError = true
        interactor?.getPosts()
        managerMock?.getPosts{ response in
            switch response {
                case .success(_):
                    break
                case .failure(let error):
                    switch error {
                        case .serverError:
                            XCTAssertTrue(self.presenterMock!.checkMessage)
                        default:
                            break
                    }
            }
        }
    }

    func test_getPosts_ResponsRequestError() {
        managerMock?.isRequestError = true
        interactor?.getPosts()
        managerMock?.getPosts{ response in
            switch response {
                case .success(_):
                    break
                case .failure(let error):
                    switch error {
                        case .requestError:
                            XCTAssertTrue(self.presenterMock!.checkMessage)
                        default:
                            break
                    }
            }
        }
    }

    func test_loadPost_WithInData() {
        interactor?.loadPost()
        managerMock?.isEmptyPostsDB = false
        managerMock?.fetchPostsFromLocalDB { response in
            switch response {
                case .success(let result):
                    if let data: [HomeModel.HomePost] = result as? [HomeModel.HomePost] {
                        if !data.isEmpty {
                            XCTAssertTrue(self.presenterMock!.checkPosts)
                        } else {}
                    }
                default:
                    break

            }
        }
    }

    func test_loadPost_WithOutData() {
        interactor?.loadPost()
        managerMock?.isEmptyPostsDB = true
        managerMock?.fetchPostsFromLocalDB { response in
            switch response {
                case .success(let result):
                    if let data: [HomeModel.HomePost] = result as? [HomeModel.HomePost] {
                        if !data.isEmpty {} else {
                            XCTAssertTrue(self.presenterMock!.checkPosts)
                        }
                    }
                default:
                    break

            }
        }
    }

    func test_LoadPosts_ResponsInternalError() {
        managerMock?.isInternalError = true
        interactor?.loadPost()
        managerMock?.fetchPostsFromLocalDB{ response in
            switch response {
                case .success(_):
                    break
                case .failure(let error):
                    switch error {
                        case .internalError:
                            XCTAssertTrue(self.presenterMock!.checkMessage)
                        default:
                            break
                    }
            }
        }
    }

    func test_LoadPosts_ResponsServerError() {
        managerMock?.isServerError = true
        interactor?.loadPost()
        managerMock?.fetchPostsFromLocalDB{ response in
            switch response {
                case .success(_):
                    break
                case .failure(let error):
                    switch error {
                        case .serverError:
                            XCTAssertTrue(self.presenterMock!.checkMessage)
                        default:
                            break
                    }
            }
        }
    }

    func test_LoadPosts_ResponsRequestError() {
        managerMock?.isRequestError = true
        interactor?.loadPost()
        managerMock?.fetchPostsFromLocalDB{ response in
            switch response {
                case .success(_):
                    break
                case .failure(let error):
                    switch error {
                        case .requestError:
                            XCTAssertTrue(self.presenterMock!.checkMessage)
                        default:
                            break
                    }
            }
        }
    }

    func test_removePosts() {
        interactor?.removePosts(posts: self.postsData)
        managerMock?.removeAllPosts(posts: self.postsData) { response in
            XCTAssertTrue(self.managerMock!.isRemoveAllPosts)
        }

    }

    func test_removePost() {
        interactor?.removePost(post: self.post)
        managerMock?.removePost(post: self.post) { response in
            XCTAssertTrue(self.managerMock!.isRemovePost)
        }
    }

    func test_addPostsToDB() {
        managerMock?.addPosts(posts: self.post) { response in
            XCTAssertTrue(self.managerMock!.isAddPosts)
        }
    }

}
