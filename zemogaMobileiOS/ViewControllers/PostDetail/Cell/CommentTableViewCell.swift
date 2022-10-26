//
//  CommentTableViewCell.swift
//  pruebaZemoga
//
//  Created by Oscar David Myerston Vega on 17/10/22.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(comment: Comment) {
        titleLabel.text = comment.name
        userLabel.text = comment.email
        bodyLabel.text = comment.body
    }
    
}
