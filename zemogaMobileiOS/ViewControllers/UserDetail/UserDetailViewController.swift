//
//  UserDetailViewController.swift
//  pruebaZemoga
//
//  Created by Oscar David Myerston Vega on 17/10/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol IUserDetailViewController: AnyObject {
	var router: IUserDetailRouter? { get set }
    func setDataUser(data: UserDetailModel.User)

}

class UserDetailViewController: UIViewController {
	var interactor: IUserDetailInteractor?
	var router: IUserDetailRouter?
    private var user: UserDetailModel.User!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var websiteButton: UIButton!
    @IBOutlet weak var companyLabel: UILabel!

	override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.getInfoUser()
    }

    @IBAction func openWebsite(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "http://\(user.website ?? "")")!, options: [:]) { (success) in
            print(success)
            if !success{
                let alert = UIAlertController(title: "Error", message: "Could not load page!", preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
        }

    }

}

extension UserDetailViewController: IUserDetailViewController {

    func setDataUser(data: UserDetailModel.User) {
        self.user = data
        self.nameLabel?.text = data.name
        self.userLabel?.text = data.username
        self.emailLabel?.text = data.email
        self.cityLabel?.text = data.address?.city
        self.addressLabel?.text = "\(data.address?.street ?? ""), \(data.address?.suite ?? "")"
        self.phoneLabel?.text = data.phone
        self.websiteButton?.setTitle(data.website, for: .normal)
        self.companyLabel?.text = data.company?.name
    }

}

extension UserDetailViewController {
	// do someting...
}

extension UserDetailViewController {
	// do someting...
}
