//
//  ModalViewController.swift
//  BookMemo
//
//  Created by 芝本　将豊 on 2019/07/19.
//  Copyright © 2019 芝本　将豊. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {

    @IBOutlet var label: UILabel!
    @IBOutlet var textField: UITextField!
    @IBOutlet var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //buttonのメソッド
        button.addTarget(self, action: #selector(pushOK), for: .touchUpInside)
        //textFieldの入力時のメソッド
        textField.addTarget(self, action: #selector(judgeButtonEnable), for: .editingChanged)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //フォント設定
        label.font = UIFont(name: "03SmartFontUI", size: label.frame.size.height * 0.65)
        button.titleLabel?.font = UIFont(name: "03SmartFontUI", size: 17)
        textField.font = UIFont(name: "03SmartFontUI", size: textField.frame.size.height * 0.4)
        //TextFieldの下線
        let buttomLine = CALayer()
        buttomLine.borderWidth = CGFloat(2.0)
        buttomLine.borderColor = (UIColor(red: 24/255, green: 95/255, blue: 48/255, alpha: 1)).cgColor
        buttomLine.frame = CGRect(x: 0, y: textField.frame.size.height * 0.75, width: textField.frame.size.width, height: 1)
        textField.layer.addSublayer(buttomLine)
        //textField初期化
        textField.text = ""
        //button初期化
        button.isEnabled = false
    }

    //button押した時
    @objc func pushOK() {
        //消える
        self.dismiss(animated: true, completion: nil)
        //親viewに値を受け渡し
        let navigationController = self.presentingViewController as! UINavigationController
        let bookListViewController = navigationController.topViewController as! BookListViewController
        bookListViewController.newBook = self.textField.text!.trimmingCharacters(in: .whitespaces)
        //親viewにcell追加させる
        bookListViewController.addBook()
    }
    
    //textFieldが空の時button押せない
    @objc func judgeButtonEnable() {
        if textField.text!.trimmingCharacters(in: .whitespaces) == "" {
            button.isEnabled = false
        } else {
            button.isEnabled = true
        }
    }
    
    //textField以外のところを触ると編集終わり
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.endEditing(true)
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
