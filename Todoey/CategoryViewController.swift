//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Julio Errecart on 5/9/26.
//  Copyright © 2026 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()

    var categories: Results<Category>?

    override func viewDidLoad() {
        
        super.viewDidLoad()

        loadCategories()
        
    }    
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories?.count ?? 1
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // We get the cell from the superclass!
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        // ...and then add our specific subclass logic
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet"

        return cell
        
    }

    //MARK: - TableView Delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
        
    }
    
    //MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {

        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            // What will happen when the user clicks the Add Category button on our UIAlert
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            self.save(category: newCategory)
            
        }
        
        alert.addTextField { (field) in
            field.placeholder = "Add a new category"
            textField = field
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)

    }
        
    //MARK: - Model Manipulation Methods
    
    func save(category: Category) {
        
        do {
            
            try realm.write {
                realm.add(category)
            }

        } catch {
            print("Error saving category \(error)")
        }

        tableView.reloadData()

    }
    
    func loadCategories() {

        categories = realm.objects(Category.self)
        
        tableView.reloadData()

    }

    //MARK: - Delete Data From Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        
        // No real need to call the superclass - Just to demonstrate method overriding
        super.updateModel(at: indexPath)

        print("CategoryViewController -> updateModel()")
        
        if let categoryForDeletion = categories?[indexPath.row] {

            do {

                try realm.write {
                    realm.delete(categoryForDeletion)
                }

            } catch {
                print("Error deleting category, \(error)")
            }

        }

    }
    
}
