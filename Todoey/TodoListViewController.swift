//
//  ViewController.swift
//  Todoey
//
//  Created by Anton on 28.07.18.
//  Copyright © 2018 Anton. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    //get the documents-folder from the FileManager.default (Singleton)
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // print(dataFilePath)
        
        loadItems()
    }
    
    //MARK - TableView DataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath) as! CustomCell
        
        let item = itemArray[indexPath.row]
        
        cell.cellLabel.text! = item.title
        
        //Ternary Operator:
        // var = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none

        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.reloadData()
    }
    
    //MARK - Add new Item
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new to do", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // What will happen
            print (textField.text!)
            self.itemArray.append(Item(textField.text!, false))
            
            self.saveData()
            
            self.tableView.reloadData()
        }
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            }
            catch {
                print("Error while encoding data :(")
            }
        }
    }
    
    func saveData() {
        // make itemArray persistent
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            // Items of itemArray (Item) must implement :Encodable or contain only default data types
            try data.write(to: dataFilePath!)
        }
        catch {
            print("Error encoding itemArray")
        }
    }
    
}

