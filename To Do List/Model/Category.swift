//
//  Category.swift
//  To Do List
//
//  Created by Aytaç Bulanık on 26.10.2024.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    @objc dynamic var cellColor : String = ""
    let items : List<Item> = List<Item>()
}
