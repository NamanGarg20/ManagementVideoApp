//
//  TableViewCell.swift
//  GapApp
//
//  Created by NAMAN GARG on 6/17/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var chapterLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
