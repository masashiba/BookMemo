//
//  MemoListViewController.swift
//  BookMemo
//
//  Created by 芝本　将豊 on 2019/06/21.
//  Copyright © 2019 芝本　将豊. All rights reserved.
//

import UIKit
import RealmSwift

class MemoListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate{

    //Outlet変数
    @IBOutlet var table : UITableView!
    @IBOutlet var addMemoButton : UIButton!
    @IBOutlet var searchBar : UISearchBar!
    
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
    //検索した結果の配列
    var searchData = [(String,Int)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //delegateとdataSource
        table.delegate = self
        table.dataSource = self
        searchBar.delegate = self
        //UI設定
        table.tableFooterView = UIView()
        
        navigationItem.largeTitleDisplayMode = .never
        
        addMemoButton.layer.cornerRadius = 30
        addMemoButton.titleLabel?.font = UIFont(name: "03SmartFontUI", size: 40)
        
        searchBar.backgroundImage = UIImage()
        navigationController?.navigationBar.shadowImage = UIImage()

        //cell準備
        table.register(UINib(nibName: "BookListTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        
        reset()
    }
    
    @objc func returnView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = table.dequeueReusableCell(withIdentifier: "CustomCell") as! BookListTableViewCell
        customCell.bookNameLabel.text = searchData[indexPath.row].0
        return customCell
    }
    
    //cellの高さ設定
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    //cell削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.delete(index: searchData[indexPath.row].1)
        searchData.remove(at: indexPath.row)
        table.deleteRows(at: [indexPath], with: .fade)
    }
    
    //cellが押された時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let realm = try! Realm()
        let memo = realm.objects(Book.self)[bookNumber].memos[searchData[indexPath.row].1]
        memoTitle = memo.title
        memoContent = memo.content
        memoNumber = searchData[indexPath.row].1
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
            reset()
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
            reset()
            table.reloadData()
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
            memoViewController.navigationItem.title = self.memoTitle
            memoViewController.contentString = self.memoContent
            memoViewController.memoNumber = self.memoNumber
            memoViewController.isNewMemo = false
        } else {
            memoViewController.contentString = ""
            memoViewController.isNewMemo = true
        }
    }
    
    //searchBar以外を触ったら入力終了
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.endEditing(true)
        search(searchBar)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(searchBar)
    }
    
    func search(_ searchBar: UISearchBar) {
        reset()
        if searchBar.text! != "" {
            searchBar.endEditing(true)
            let dataArray = searchData
            searchData = dataArray.filter{
                $0.0.lowercased().contains(searchBar.text!.lowercased())
            }
            table.reloadData()
        } else {
            table.reloadData()
        }
    }
    
    func reset() {
        let realm = try! Realm()
        let memos = realm.objects(Book.self)[bookNumber].memos
        searchData = [(String,Int)]()
        for i in 0..<memos.count {
            searchData.append((memos[i].title,i))
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
