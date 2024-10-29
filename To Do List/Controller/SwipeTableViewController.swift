//
//  SwipeTableViewController.swift
//  To Do List
//
//  Created by Aytaç Bulanık on 29.10.2024.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController , SwipeTableViewCellDelegate {

    var cell : UITableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
       
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            self.updateModel(at: indexPath)
        }

        // customize the action appearance
        deleteAction.image = UIImage(named: "delete")

        return [deleteAction]
    }
    
    func updateModel(at indexPath : IndexPath){
        
    }

}
