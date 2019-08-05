//
//  BookName.swift
//  BookMemo
//
//  Created by 芝本　将豊 on 2019/07/30.
//  Copyright © 2019 芝本　将豊. All rights reserved.
//

import UIKit
import RealmSwift

class BookNameRealm: Object {
    dynamic var bookNameList = [String]();
}
