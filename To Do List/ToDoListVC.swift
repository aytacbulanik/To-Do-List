//
//  ViewController.swift
//  To Do List
//
//  Created by Aytaç Bulanık on 21.10.2024.
//

import UIKit

class ToDoListVC: UITableViewController {
    
    var shoppingList: [String] = ["Egg","Milk","Bread","Cheese","Chocolate","Water","Coffee","Tea","Papaya"]

    override func viewDidLoad() {
        super.viewDidLoad()
        shoppingList = UserDefaults.standard.array(forKey: "shoppingList") as? [String] ?? []
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

    
    @IBAction func newTodoPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "New ToDo", message: "", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Enter new item"
        }
        let okButton = UIAlertAction(title: "Add Item", style: .default) { action in
            guard let text = alert.textFields?[0].text else { return }
            if !text.isEmpty {
                self.shoppingList.append(text.capitalized)
                UserDefaults.standard.set(self.shoppingList, forKey: "shoppingList")
                self.tableView.reloadData()
            }
        }
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
    

}

