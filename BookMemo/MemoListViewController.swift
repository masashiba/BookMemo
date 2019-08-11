//
//  MemoListViewController.swift
//  BookMemo
//
//  Created by 芝本　将豊 on 2019/06/21.
//  Copyright © 2019 芝本　将豊. All rights reserved.
//

import UIKit
import RealmSwift

class MemoListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    //Outlet変数
    @IBOutlet var table : UITableView!
    @IBOutlet var navBar : UINavigationBar!
    @IBOutlet var navItem : UINavigationItem!
    @IBOutlet var addMemoButton : UIButton!
    //navigationBarのtitle入れる変数
    var titleString = String()
    //新しいメモの情報を一時的に格納する変数
    var newMemoTitle = String()
    var newMemoContent = String()
    //値渡しのための変数
    var memoTitle = String()
    var memoContent = String()
    var memoNumber = Int()
    //どの本かを示す変数
    var bookNumber = Int()
    //MemoがあるかどうかのBool型変数
    var isNewMemoEmpty = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //delegateとdataSource
        table.delegate = self
        table.dataSource = self
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
        addMemoButton.layer.cornerRadius = 30
        addMemoButton.titleLabel?.font = UIFont(name: "03SmartFontUI", size: 40)
        //cell準備
        table.register(UINib(nibName: "BookListTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        // Do any additional setup after loading the view.
    }
    
    @objc func returnView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realm = try! Realm()
        let book = realm.objects(Book.self)[bookNumber]
        return book.memos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let realm = try! Realm()
        let memos = realm.objects(Book.self)[bookNumber].memos
        let customCell = table.dequeueReusableCell(withIdentifier: "CustomCell") as! BookListTableViewCell
        customCell.bookNameLabel.text = memos[indexPath.row].title
        return customCell
    }
    
    //cell削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.delete(index: indexPath.row)
        table.deleteRows(at: [indexPath], with: .fade)
    }
    
    //cellが押された時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let realm = try! Realm()
        let book = realm.objects(Book.self)[bookNumber]
        memoTitle = book.memos[indexPath.row].title
        memoContent = book.memos[indexPath.row].content
        memoNumber = indexPath.row
        performSegue(withIdentifier: "toMemoDetail", sender: nil)
        table.deselectRow(at: indexPath, animated: true)
    }
    
    func addMemo() {
        if !isNewMemoEmpty {
            let memo = Memo()
            memo.title = newMemoTitle
            memo.content = newMemoContent
            do {
                let realm = try Realm()
                let book = realm.objects(Book.self)[bookNumber]
                try realm.write {
                    book.memos.append(memo)
                }
            } catch {
                
            }
            table.reloadData()
        }
    }
    
    func update() {
        if isNewMemoEmpty {
            self.delete(index: memoNumber)
            table.reloadData()
        } else {
            do {
                let realm = try! Realm()
                let book = realm.objects(Book.self)[bookNumber]
                try realm.write {
                    book.memos[memoNumber].title = newMemoTitle
                    book.memos[memoNumber].content = newMemoContent
                }
            } catch {
                
            }
        }
    }

    func delete(index: Int) {
        do {
            let realm = try! Realm()
            let book = realm.objects(Book.self)[bookNumber]
            try realm.write {
                book.memos.remove(at: index)
            }
        } catch {
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let memoViewController = segue.destination as! MemoViewController
        if segue.identifier == "toMemoDetail" {
            memoViewController.titleString = self.memoTitle
            memoViewController.contentString = self.memoContent
            memoViewController.memoNumber = self.memoNumber
            memoViewController.isNewMemo = false
        } else {
            memoViewController.contentString = ""
            memoViewController.isNewMemo = true
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
