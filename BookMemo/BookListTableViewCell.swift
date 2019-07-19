//
//  BookListTableViewCell.swift
//  BookMemo
//
//  Created by 芝本　将豊 on 2019/07/05.
//  Copyright © 2019 芝本　将豊. All rights reserved.
//

import UIKit

class BookListTableViewCell: UITableViewCell {

    @IBOutlet var bookNameLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bookNameLabel.font = UIFont(name: "03SmartFontUI", size: 22)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
