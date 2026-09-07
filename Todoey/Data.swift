//
//  Data.swift
//  Todoey
//
//  Created by Julio Errecart on 7/9/26.
//  Copyright © 2026 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Data : Object {
    
    @objc dynamic var name : String = ""
    @objc dynamic var age : Int = 0
    
}
