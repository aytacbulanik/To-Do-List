//
//  ViewController.swift
//  To Do List
//
//  Created by Aytaç Bulanık on 21.10.2024.
//

import UIKit

class ToDoListVC: UITableViewController {
    
    var shoppingList: [Item] = []
    let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadItems()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        cell.textLabel?.text = shoppingList[indexPath.row].title
        
        let item = shoppingList[indexPath.row]
        cell.accessoryType =  item.done ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        shoppingList[indexPath.row].done = !shoppingList[indexPath.row].done
        saveItem()
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
                let newItem = Item()
                newItem.title = text.capitalized
                self.shoppingList.append(newItem)
                self.saveItem()
            }
        }
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
    
    func saveItem() {
        let encoder = PropertyListEncoder()
        do {
           let data =  try encoder.encode(self.shoppingList)
            try data.write(to: self.documentPath!)
        } catch {
            print(error.localizedDescription)
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: self.documentPath!) {
            let decoder = PropertyListDecoder()
            do {
                shoppingList = try decoder.decode([Item].self, from: data)
            }catch {
                print(error.localizedDescription)
            }
        }
    }
    

}

