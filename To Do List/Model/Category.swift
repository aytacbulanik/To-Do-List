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
    let items : List<Item> = List<Item>()
}
