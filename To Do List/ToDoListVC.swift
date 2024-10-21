//
//  ViewController.swift
//  To Do List
//
//  Created by Aytaç Bulanık on 21.10.2024.
//

import UIKit

class ToDoListVC: UITableViewController {
    
    var shoppingList: [String] = ["Egg","Milk","Bread","Cheese","Chocolate","Water","Coffee","Tea","Juice","Apple","Banana","Orange","Pear","Grapefruit","Strawberry","Kiwi","Pineapple","Mango","Lemon","Lime","Papaya"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }


}

