//
//  MemoListViewController.swift
//  BookMemo
//
//  Created by 芝本　将豊 on 2019/06/21.
//  Copyright © 2019 芝本　将豊. All rights reserved.
//

import UIKit

class MemoListViewController: UIViewController {

    //Outlet変数
    @IBOutlet var table : UITableView!
    @IBOutlet var navBar : UINavigationBar!
    @IBOutlet var navItem : UINavigationItem!
    @IBOutlet var addCellButton : UIButton!
    //navigationBarのtitle入れる変数
    var titleString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //UI設定
        table.tableFooterView = UIView()
        let backBarButton = UIBarButtonItem(title: "戻る", style: UIBarButtonItem.Style.plain, target: self, action:#selector(self.returnView))
        backBarButton.tintColor = UIColor.white
        navItem.leftBarButtonItem = backBarButton
        navItem.title = titleString
        navBar.titleTextAttributes =
            [NSAttributedString.Key.font: UIFont(name: "03SmartFontUI", size: 18) as Any,
             NSAttributedString.Key.foregroundColor: UIColor.white]
        navBar.pushItem(navItem, animated: true)
        addCellButton.layer.cornerRadius = 30
        addCellButton.titleLabel?.font = UIFont(name: "03SmartFontUI", size: 40)
        // Do any additional setup after loading the view.
    }
    
    @objc func returnView() {
        self.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
