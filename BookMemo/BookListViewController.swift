//
//  BookListViewController.swift
//  BookMemo
//
//  Created by 芝本　将豊 on 2019/06/21.
//  Copyright © 2019 芝本　将豊. All rights reserved.
//

import UIKit
import PopupDialog

class BookListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{

    //Outlet変数
    @IBOutlet var label : UILabel!
    @IBOutlet var table : UITableView!
    @IBOutlet var addCellButton : UIButton!
    
    //本の名前の配列
    var bookNameArray = [String]()
    
    //ModalViewのインスタンス作成
    let modalView = ModalViewController(nibName: "ModalViewController", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //delegateとdataSource
        table.delegate = self
        table.dataSource = self
        // Do any additional setup after loading the view.
        //UI設定
        label.font = UIFont(name: "03SmartFontUI", size: 45)
        addCellButton.layer.cornerRadius = 30
        addCellButton.titleLabel?.font = UIFont(name: "03SmartFontUI", size: 40)
        table.tableFooterView = UIView()
        //cell準備
        table.register(UINib(nibName: "BookListTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        //ButtonのAction追加
        addCellButton.addTarget(self, action: #selector(self.addCell(_:)), for: UIControl.Event.touchUpInside)
    }
    
    //追加ボタンを押した時の挙動
    @objc func addCell(_ sender: UIButton) {
        //背景透過
        let overlayAppearance = PopupDialogOverlayView.appearance()
        overlayAppearance.color           = .white
        overlayAppearance.blurRadius      = 5
        overlayAppearance.blurEnabled     = true
        overlayAppearance.liveBlurEnabled = false
        overlayAppearance.opacity         = 0.2
        //PopUp作成
        let popup = PopupDialog(viewController: modalView, transitionStyle: .zoomIn)
        //PopUp表示
        present(popup, animated: true, completion: {() -> Void in
            print("hoge")
        })
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return table.dequeueReusableCell(withIdentifier: "CustomCell") as! BookListTableViewCell
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
