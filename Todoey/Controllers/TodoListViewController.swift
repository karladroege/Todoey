//
//  ViewController.swift
//  Todoey
//
//  Created by Droege, Karla on 1/4/19.
//  Copyright © 2019 Droege, Karla. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var listArray = [Item]()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let findMike = Item(title: "Find Mike")
        listArray.append(findMike)
        let eggos = Item(title: "Buy Eggos")
        listArray.append(eggos)
        let monster = Item(title: "Destroy Demogorgon")
        listArray.append(monster)
        
        if let listItems = defaults.array(forKey: "TodoListArray") as? [Item] {
            listArray = listItems
        }
    }
    
    //MARK - Datasource Methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = listArray[indexPath.row].title
        
        cell.accessoryType = listArray[indexPath.row].done ? .checkmark : .none
        return cell
    }
    
    //MARK - Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listArray[indexPath.row].done = !listArray[indexPath.row].done
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New To Do Item", message: "This is the message", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newItem = Item(title: textField.text!)
            
            self.listArray.append(newItem)
            self.defaults.set(self.listArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }

}

