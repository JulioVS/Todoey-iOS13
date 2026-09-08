//
//  Category.swift
//  Todoey
//
//  Created by Julio Errecart on 7/9/26.
//  Copyright © 2026 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    
    @objc dynamic var name : String = ""
    let items = List<Item>()
    
}
