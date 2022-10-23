//
//  HomeViewController.swift
//  pruebaZemoga
//
//  Created by Oscar David Myerston Vega on 17/10/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol IHomeViewController: AnyObject {
    var router: IHomeRouter? { get set }
    func posts(parameters: [HomeModel.HomePost])
    func deleteInfo(to: IndexPath)
    func loadingHide()

}

class HomeViewController: UIViewController {
    var interactor: IHomeInteractor?
    var router: IHomeRouter?
    private var posts: [HomeModel.HomePost] = []
    private let postsCell = "PostTableViewCell"

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        loadPosts()
        configureNavigation()

    }

    override func viewWillAppear(_ animated: Bool) {

        if posts.isEmpty {
            showLoading(to: view)
        }
    }

    private func loadPosts() {
        interactor?.loadPost()
    }

    private func configureNavigation() {
        title = "Zemoga Posts"
        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .refresh,
                                                         target: self, action: #selector(loadAllPost)),
                                         animated: true)
        navigationItem.setLeftBarButton(UIBarButtonItem(barButtonSystemItem: .trash,
                                                        target: self, action: #selector(deleteAll)),
                                        animated: true)

    }

    @objc func loadAllPost() {
        if posts.isEmpty {
            interactor?.loadPost()
        }
    }

    @objc func deleteAll() {
        if !posts.isEmpty {
            self.trashAll()
        }
    }

    private func removeAll() {
        self.posts.removeAll()
        tableView.reloadData()
    }

    private func configureTableView() {
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        setTableViewDelegate()
        tableView.register(UINib(nibName: self.postsCell, bundle: nil), forCellReuseIdentifier: self.postsCell)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        tableView.layer.backgroundColor = CGColor.init(gray: 1, alpha: 1)

    }

    private func setTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension HomeViewController: IHomeViewController {
    
    func posts(parameters: [HomeModel.HomePost]) {
        posts = parameters
        configureTableView()
        tableView.reloadData()
        hideLoading()
    }

    func loadingHide() {
        self.hideLoading()
    }

    func deleteInfo(to: IndexPath) {
        self.interactor?.removePost(post: posts[to.row])
        posts.remove(at: to.row)
        tableView.beginUpdates()
        tableView.deleteRows(at: [to], with: .middle)
        tableView.endUpdates()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = posts.count
        if count == 0 {
            tableView.setEmptyMessage(HomeModel.Constants.emptyListMessage)
        } else {
            tableView.restore()
        }
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.postsCell, for: indexPath) as? PostTableViewCell
        let posts = posts[indexPath.row]
        cell?.selectionStyle = .none
        cell?.set(posts: posts)
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post: HomeModel.HomePost = posts[indexPath.row]
        debugPrint("**** POST: \(post)")
        self.router?.navigationToPostDetail(post: post)

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Remove") { ( _, _, _) in
            DispatchQueue.main.async {
                self.trash(indexPath: indexPath)
            }
        }
        delete.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [delete])
    }


}

extension HomeViewController {

    private func trash(indexPath: IndexPath) {
        let alert = UIAlertController(title:"WARNING",
                                      message:"Do You want to delete the selected title?",
                                      preferredStyle: .alert)

        let ok = UIAlertAction(title: "OK",
                               style: .default,
                               handler: { (_: UIAlertAction!) -> Void in
            DispatchQueue.main.async {
                    self.deleteInfo(to: indexPath)
            }
        })

        let destroyAction = UIAlertAction(title: "GO BACK",
                                          style: .destructive,
                                          handler: { (_: UIAlertAction!) -> Void in
            self.tableView.reloadData()
        })
        alert.addAction(destroyAction)
        alert.addAction(ok)

        alert.setValue(NSAttributedString(string: "WARNING",
                                          attributes:
                                            [NSAttributedString.Key.foregroundColor:  UIColor.black,
                                             NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 18)!]),
                       forKey: "attributedTitle")
        alert.setValue(NSAttributedString(string: "Do You want to delete the selected title?",
                                          attributes: [NSAttributedString.Key.foregroundColor:  UIColor.black, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 18)!]), forKey: "attributedMessage")

        let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        subview.backgroundColor = UIColor(red: 247 / 255, green: 248 / 255, blue: 247 / 255, alpha: 1)
        alert.view.tintColor = UIColor(red: 124 / 255, green: 178 / 255, blue: 48 / 255, alpha: 1)
        self.present(alert, animated: true, completion: nil)
    }

    private func trashAll() {
        let alert = UIAlertController(title:"WARNING",
                                      message:"Do You want to delete the selected title?",
                                      preferredStyle: .alert)

        let ok = UIAlertAction(title: "OK",
                               style: .default,
                               handler: { (_: UIAlertAction!) -> Void in
            DispatchQueue.main.async {
                self.removeAll()
                self.interactor?.removePosts(posts: self.posts)
            }
        })

        let destroyAction = UIAlertAction(title: "GO BACK",
                                          style: .destructive,
                                          handler: { (_: UIAlertAction!) -> Void in
            self.tableView.reloadData()
        })
        alert.addAction(destroyAction)
        alert.addAction(ok)

        alert.setValue(NSAttributedString(string: "WARNING",
                                          attributes:
                                            [NSAttributedString.Key.foregroundColor:  UIColor.black,
                                             NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 18)!]),
                       forKey: "attributedTitle")
        alert.setValue(NSAttributedString(string: "Do You want to delete the selected title?",
                                          attributes: [NSAttributedString.Key.foregroundColor:  UIColor.black, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 18)!]), forKey: "attributedMessage")

        let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        subview.backgroundColor = UIColor(red: 247 / 255, green: 248 / 255, blue: 247 / 255, alpha: 1)
        alert.view.tintColor = UIColor(red: 124 / 255, green: 178 / 255, blue: 48 / 255, alpha: 1)
        self.present(alert, animated: true, completion: nil)
    }
}
