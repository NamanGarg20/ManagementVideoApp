//
//  CommentTableViewCell.swift
//  GapAPPNew
//
//  Created by NAMAN GARG on 6/21/21.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet var date: UILabel!
    @IBOutlet var chapter: UILabel!
    @IBOutlet var comment: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
