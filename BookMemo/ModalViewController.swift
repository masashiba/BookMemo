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
        //フォント設定
        label.font = UIFont(name: "03SmartFontUI", size: 15)
        button.titleLabel?.font = UIFont(name: "03SmartFontUI", size: 17)
        //TextFieldの下線
        let buttomLine = CALayer()
        buttomLine.borderWidth = CGFloat(2.0)
        buttomLine.borderColor = UIColor.green.cgColor
        buttomLine.frame = CGRect(x: 0, y: textField.frame.size.height - 2.0, width: textField.frame.size.width, height: 1)
        textField.layer.addSublayer(buttomLine)
        // Do any additional setup after loading the view.
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
