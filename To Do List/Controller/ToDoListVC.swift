//
//  ViewController.swift
//  To Do List
//
//  Created by Aytaç Bulanık on 21.10.2024.
//

import UIKit
import RealmSwift

class ToDoListVC: UITableViewController {
    
    var itemArray : Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory: Category? {
        didSet {
            loadItem()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        
        
        if let item = itemArray?[indexPath.row] {
            cell.accessoryType =  item.done ? .checkmark : .none
            cell.textLabel?.text = item.title
        } else {
            cell.textLabel?.text = "No items added yet"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = itemArray?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
        tableView.reloadData()
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
                if let currentCategory = self.selectedCategory {
                    do {
                        try self.realm.write {
                            let newItem = Item()
                            newItem.title = text.capitalized
                            currentCategory.items.append(newItem)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            self.tableView.reloadData()
        }
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
    
    func saveItem() {
       
    }
    
    func loadItem() {
        itemArray = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
    }
    
    
    

}

