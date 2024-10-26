//
//  CategoryVC.swift
//  To Do List
//
//  Created by Aytaç Bulanık on 26.10.2024.
//

import UIKit
import RealmSwift

class CategoryVC: UITableViewController {
    
    let realm = try! Realm()
    
    var categories = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }

    @IBAction func categoryButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        alert.addTextField { field in
            textField = field
            textField.placeholder = "Category Name"
        }
        let addButton = UIAlertAction(title: "Add Category", style: .default) { action in
            if let textFieldText = textField.text {
                let category = Category()
                category.name = textFieldText
                self.categories.append(category)
                self.saveCategories(category: category)
            }
            self.tableView.reloadData()
        }
        alert.addAction(addButton)
        present(alert, animated: true)
        
    }
    
    func saveCategories(category : Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadCategories() {
        
    }

}
