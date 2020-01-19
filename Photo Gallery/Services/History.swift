//
//  RealmHelper.swift
//  Photo Gallery
//
//  Created by Deniro21 on 1/16/20.
//  Copyright © 2020 Denys Hryshyn. All rights reserved.
//

import Foundation
import RealmSwift

class History: Object {
    
    @objc dynamic var photoName = ""
    @objc dynamic var photoImg: NSData? = nil
}
