//
//  MemoNavigationBar.swift
//  BookMemo
//
//  Created by 芝本　将豊 on 2019/06/21.
//  Copyright © 2019 芝本　将豊. All rights reserved.
//

import UIKit

class MemoNavigationBar: UINavigationBar {

    
    override func awakeFromNib() {
        let navItem = UINavigationItem(title: "")
        self.isTranslucent = false
        self.barTintColor = UIColor(red: 24.0 / 255.0, green: 95.0 / 255.0, blue: 48.0 / 255.0, alpha: 1.0)
        self.tintColor = .white
        self.pushItem(navItem, animated: true)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
