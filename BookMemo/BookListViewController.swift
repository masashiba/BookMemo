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
    //受け渡すタイトルを入れる変数
    var titleText = String()
    //ModalViewのインスタンス作成
    let modalView = ModalViewController(nibName: "ModalViewController", bundle: nil) as UIViewController
    
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
        addCellButton.addTarget(self, action: #selector(presentModal), for: UIControl.Event.touchUpInside)
    }
    
    //追加ボタンを押した時の挙動
    @objc func presentModal() {
        //背景透過
        let overlayAppearance = PopupDialogOverlayView.appearance()
        overlayAppearance.color           = .white
        overlayAppearance.blurRadius      = 5
        overlayAppearance.blurEnabled     = true
        overlayAppearance.liveBlurEnabled = false
        overlayAppearance.opacity         = 0.2
        //PopUp作成
        let popup = PopupDialog(viewController: modalView, transitionStyle: .zoomIn, preferredWidth: 220) as UIViewController
        //PopUp表示
        present(popup, animated: true, completion: {() -> Void in
            
        })
    }

    
    
    //bookNameArrayの中身を順番にcellに格納
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = table.dequeueReusableCell(withIdentifier: "CustomCell") as! BookListTableViewCell
        customCell.bookNameLabel.text = bookNameArray[indexPath.row]
        return customCell
    }
    
    //cellが押されたら画面遷移
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        titleText = bookNameArray[indexPath.row]
        performSegue(withIdentifier: "toMemoList", sender: nil)
        table.deselectRow(at: indexPath, animated: true)
    }
    
    //cell削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        bookNameArray.remove(at: indexPath.row)
        table.deleteRows(at: [indexPath], with: .fade)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMemoList" {
            let memoListViewController = segue.destination as! MemoListViewController
            memoListViewController.titleString = titleText
        }
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
