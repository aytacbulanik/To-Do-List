//
//  CategoryVC.swift
//  To Do List
//
//  Created by Aytaç Bulanık on 26.10.2024.
//

import UIKit
import RealmSwift

class CategoryVC: SwipeTableViewController {
    
    let realm = try! Realm()
    
    var categories : Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListVC
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
        
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
                self.saveCategories(category: category)
            }
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
        tableView.reloadData()
    }
    
    func loadCategories() {
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let currentCategory = categories?[indexPath.row] {
            do {
                try realm.write {
                    realm.delete(currentCategory)
                }
            } catch {
                print(error.localizedDescription)
            }
            tableView.reloadData()
        }
    }

}


