//
//  BookListViewController.swift
//  BookMemo
//
//  Created by 芝本　将豊 on 2019/06/21.
//  Copyright © 2019 芝本　将豊. All rights reserved.
//

import UIKit
import PopupDialog
import RealmSwift

class BookListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{

    //Outlet変数
    @IBOutlet var label : UILabel!
    @IBOutlet var table : UITableView!
    @IBOutlet var addCellButton : UIButton!
    @IBOutlet var searchBar : UISearchBar!
    //追加する本の名前を一時的に入れる変数
    var newBook = String()
    //受け渡すタイトルを入れる変数
    var titleText = String()
    //ModalViewのインスタンス作成
    let modalView = ModalViewController(nibName: "ModalViewController", bundle: nil) as UIViewController
    //どの本かを示す変数
    var bookNumber = Int()
    //検索した結果の配列
    var searchData = [(String,Int)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //delegateとdataSource
        table.delegate = self
        table.dataSource = self
        searchBar.delegate = self
        
        //UI設定
        addCellButton.layer.cornerRadius = 30
        addCellButton.titleLabel?.font = UIFont(name: "03SmartFontUI", size: 40)
        table.tableFooterView = UIView()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.font: UIFont(name: "03SmartFontUI", size: 40) as Any,
             NSAttributedString.Key.foregroundColor: UIColor.white]

                
        searchBar.backgroundImage = UIImage()
        navigationController?.navigationBar.shadowImage = UIImage()
                
        //cell準備
        table.register(UINib(nibName: "BookListTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        //ButtonのAction追加
        addCellButton.addTarget(self, action: #selector(presentModal), for: UIControl.Event.touchUpInside)
        
        reset()
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
    
    //cellが押されたら画面遷移
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        titleText = searchData[indexPath.row].0
        bookNumber = searchData[indexPath.row].1
        performSegue(withIdentifier: "toMemoList", sender: nil)
        table.deselectRow(at: indexPath, animated: true)
    }
    
    //cell削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.delete(index: searchData[indexPath.row].1)
        searchData.remove(at: indexPath.row)
        table.deleteRows(at: [indexPath], with: .fade)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMemoList" {
            let memoListViewController = segue.destination as! MemoListViewController
            memoListViewController.navigationItem.title = titleText
            memoListViewController.bookNumber = self.bookNumber
        }
    }
    
    func addBook() {
        let book = Book()
        book.bookName = newBook
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(book)
            }
        } catch {
            
        }
//        table.reloadData()
        self.search(searchBar)
    }
    
    func delete(index: Int) {
        do {
            let realm = try! Realm()
            let books = realm.objects(Book.self)
            try realm.write {
                realm.delete(books[index])
            }
        } catch {
            
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
        let books = realm.objects(Book.self)
        searchData = [(String,Int)]()
        for i in 0..<books.count {
            searchData.append((books[i].bookName,i))
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
