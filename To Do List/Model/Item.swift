//
//  Item.swift
//  To Do List
//
//  Created by Aytaç Bulanık on 23.10.2024.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCraeted: Date = Date()
    var parentCategory  = LinkingObjects<Category>(fromType: Category.self, property: "items")
}
