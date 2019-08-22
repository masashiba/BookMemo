//
//  MemoViewController.swift
//  BookMemo
//
//  Created by 芝本　将豊 on 2019/06/21.
//  Copyright © 2019 芝本　将豊. All rights reserved.
//

import UIKit

class MemoViewController: UIViewController {

    //Outlet変数
    @IBOutlet var navBar : UINavigationBar!
    @IBOutlet var navItem : UINavigationItem!
    @IBOutlet var titleTextField : UITextField!
    @IBOutlet var textView : UITextView!
    //navigationBarのtitle入れる変数
    var titleString = "無題のメモ"
    var contentString = String()
    var memoNumber = Int()
    //新しいメモかどうかの判定
    var isNewMemo = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //UI設定
        let backBarButton = UIBarButtonItem(title: "戻る", style: UIBarButtonItem.Style.plain, target: self, action:#selector(self.returnView))
        backBarButton.tintColor = UIColor.white
        navItem.leftBarButtonItem = backBarButton
        navItem.title = titleString
        textView.text = contentString
        navBar.titleTextAttributes =
            [NSAttributedString.Key.font: UIFont(name: "03SmartFontUI", size: 18) as Any,
             NSAttributedString.Key.foregroundColor: UIColor.white]
        navBar.pushItem(navItem, animated: true)
        titleTextField.font = UIFont(name: "03SmartFontUI", size: 20)
        let buttomLine = CALayer()
        buttomLine.borderWidth = CGFloat(2.0)
        buttomLine.borderColor = (UIColor.white).cgColor
        buttomLine.frame = CGRect(x: 0, y: titleTextField.frame.size.height * 0.9, width: titleTextField.frame.size.width, height: 1)
        titleTextField.layer.addSublayer(buttomLine)
        titleTextField.textColor = .white
        titleTextField.text = titleString
        textView.font = UIFont(name: "03SmartFontUI", size: 16)
        //編集が終わった時にタイトルを反映
        titleTextField.addTarget(self, action: #selector(presentTitle), for: .editingDidEnd)
        // Do any additional setup after loading the view.
    }
    
    @objc func returnView() {
        self.dismiss(animated: true, completion: nil)
        //値の受け渡し
        let memoListViewController = self.presentingViewController as! MemoListViewController
        memoListViewController.newMemoTitle = self.titleString
        memoListViewController.newMemoContent = self.textView.text.trimmingCharacters(in: .newlines)
        memoListViewController.isNewMemoEmpty = self.textView.text.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        if isNewMemo {
            memoListViewController.addMemo()
        } else {
            memoListViewController.memoNumber = self.memoNumber
            memoListViewController.update()
        }
    }
    
    @objc func presentTitle() {
        if titleTextField.text!.trimmingCharacters(in: .whitespaces) != "" {
            titleString = titleTextField.text!.trimmingCharacters(in: .whitespaces)
        } else {
            titleString = "無題のメモ"
            titleTextField.text = titleString
        }
        navItem.title = titleString
    }

    //textField以外のところを触ると編集終わり
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        titleTextField.endEditing(true)
        textView.endEditing(true)
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
