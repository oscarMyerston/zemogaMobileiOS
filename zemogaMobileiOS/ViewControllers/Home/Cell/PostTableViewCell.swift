//
//  PostTableViewCell.swift
//  pruebaZemoga
//
//  Created by Oscar David Myerston Vega on 17/10/22.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageFavorite: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Initialization code
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textAlignment = .left
        titleLabel.font =  UIFont(name: "Helvetica-Regular", size: 16)
        titleLabel.textColor = .systemBlue

    }

    func set(posts: HomeModel.HomePost) {
        titleLabel?.text = posts.title
    }
    
}
