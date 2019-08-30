//
//  MemoViewController.swift
//  BookMemo
//
//  Created by 芝本　将豊 on 2019/06/21.
//  Copyright © 2019 芝本　将豊. All rights reserved.
//

import UIKit

class MemoViewController: UIViewController, UINavigationControllerDelegate {

    //Outlet変数
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
        
        navigationController?.delegate = self

        textView.text = contentString
        textView.font = UIFont(name: "03SmartFontUI", size: 16)
        
        navigationItem.largeTitleDisplayMode = .never
        
        titleTextField.font = UIFont(name: "03SmartFontUI", size: 20)
        
        let buttomLine = CALayer()
        buttomLine.borderWidth = CGFloat(2.0)
        buttomLine.borderColor = (UIColor.white).cgColor
        buttomLine.frame = CGRect(x: 0, y: titleTextField.frame.size.height * 0.9,
                                  width: titleTextField.frame.size.width, height: 1)
        titleTextField.layer.addSublayer(buttomLine)
        titleTextField.textColor = .white
        
        if navigationItem.title != nil{
            titleString = navigationItem.title!
        }
        
        titleTextField.text = titleString
        
        //編集が終わった時にタイトルを反映
        titleTextField.addTarget(self, action: #selector(presentTitle), for: .editingDidEnd)
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let memoListViewController = viewController as? MemoListViewController {
            // returnViewを移植
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
    }
    
    @objc func presentTitle() {
        if titleTextField.text!.trimmingCharacters(in: .whitespaces) != "" {
            titleString = titleTextField.text!.trimmingCharacters(in: .whitespaces)
        } else {
            titleString = "無題のメモ"
            titleTextField.text = titleString
        }
        navigationItem.title = titleString
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
