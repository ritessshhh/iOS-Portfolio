//
//  Category.swift
//  Todoey-iOS16
//
//  Created by ritessshhh on 24/07/2023.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name              : String = ""
    @objc dynamic var bgColorOfCategory : String = ""
    
    var items = List<Item>()
}
