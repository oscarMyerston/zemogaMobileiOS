//
//  PostDetailViewController.swift
//  pruebaZemoga
//
//  Created by Oscar David Myerston Vega on 17/10/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol IPostDetailViewController: AnyObject {
	var router: IPostDetailRouter? { get set }
    func loadingHide()
    func comments(parameters: [Comment])
    func setUser(parameters: UserDetailModel.User)

}

class PostDetailViewController: UIViewController {
	var interactor: IPostDetailInteractor?
	var router: IPostDetailRouter?
    private var comments = [Comment]()
    private var post: HomeModel.HomePost!
    private var user: UserDetailModel.User!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var userButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!

    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!


	override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        interactor?.getCommentsForPost()
        configureLabels()
        loadUserInfo()
        configureButton()

        favoriteButton.addTarget(self, action: #selector(buttonTapped) , for: .primaryActionTriggered)

    }

    @objc func buttonTapped(_ sender: UIButton) {
        let selected = sender.isSelected
        favoriteButton.isSelected = !selected
        self.interactor?.setFavorite(isSelected: favoriteButton.isSelected)
    }

    override func viewWillAppear(_ animated: Bool) {
        if comments.isEmpty {
            showLoading(to: view)
        }
    }

    @IBAction func userDetail(_ sender: UIButton) {
        let userDetailVc = UserDetailConfiguration.setup(parameters: ["userDetail": user as Any])
        self.navigationController?.pushViewController(userDetailVc, animated: true)
    }


}

extension PostDetailViewController: IPostDetailViewController {

    func loadingHide() {
        self.hideLoading()
    }

    func comments(parameters: [Comment]) {
        self.comments = parameters
        configureTableView()
    }

    func setUser(parameters: UserDetailModel.User) {
        self.user = parameters
        self.userButton.setTitle(parameters.username , for: .normal)
    }
}

extension PostDetailViewController {

    private func configureLabels() {
        self.post = interactor?.getPostSelected()
        if post != nil {
            self.titleLabel?.text = post.title
            self.bodyLabel?.text = post.body
            self.favoriteButton.isSelected = post.isFav!
        }
    }

    func configureNavigationBar() {
        title = "Post Detail"
    }

    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: String(describing: CommentTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: CommentTableViewCell.self))
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 73
    }

    private func loadUserInfo() {
        interactor?.getUser()
    }

    private func configureButton() {
        self.userButton.layer.cornerRadius = 16.0
        self.userButton.layer.borderWidth = 1.0
        self.userButton.clipsToBounds = true
    }

}

extension PostDetailViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CommentTableViewCell.self)) as! CommentTableViewCell
        cell.configure(comment: comments[indexPath.row])
        return cell
    }

}

extension PostDetailViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
