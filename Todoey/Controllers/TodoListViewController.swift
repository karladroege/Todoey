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
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
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
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New To Do Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newItem = Item(title: textField.text!)
            
            self.listArray.append(newItem)
            
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(listArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding items, \(error)")
        }
        tableView.reloadData()
    }
    
    func loadItems() {
        if let path = dataFilePath, let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                listArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding data, \(error)")
            }
        }
    }

}

