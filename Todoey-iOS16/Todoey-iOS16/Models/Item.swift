//
//  Item.swift
//  Todoey-iOS16
//
//  Created by ritessshhh on 24/07/2023.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var title        : String = ""
    @objc dynamic var done         : Bool   = false
    @objc dynamic var dateCreated  : Date?
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
