//
//  BookListNavigationBar.swift
//  BookMemo
//
//  Created by 芝本　将豊 on 2019/06/21.
//  Copyright © 2019 芝本　将豊. All rights reserved.
//

import UIKit

class BookListNavigationBar: UINavigationBar, UISearchBarDelegate {

    override func awakeFromNib() {
        let navItem = UINavigationItem(title: "本棚")
        
        
        navItem.largeTitleDisplayMode = .always
        self.prefersLargeTitles = true
        self.isTranslucent = false
        self.largeTitleTextAttributes = [
            .foregroundColor : UIColor.white
        ]
        self.titleTextAttributes = [
            .foregroundColor : UIColor.white
        ]
        self.barTintColor = UIColor(red: 24.0 / 255.0, green: 95.0 / 255.0, blue: 48.0 / 255.0, alpha: 1.0)
        self.pushItem(navItem, animated: true)
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height * 0.2)
        
        
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "本を検索"
        searchBar.tintColor = UIColor.gray
        searchBar.frame.origin.x = self.bounds.origin.x / 2
        searchBar.frame.origin.y = self.bounds.origin.y / 2
        self.addSubview(searchBar)
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
