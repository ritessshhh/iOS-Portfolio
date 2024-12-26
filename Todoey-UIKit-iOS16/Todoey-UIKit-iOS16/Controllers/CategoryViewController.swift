//
//  CategoryViewController.swift
//  Todoey-UIKit-iOS16
//
//  Created by ritessshhh on 15/08/2023.
//
//

import UIKit
import RealmSwift
import SwipeCellKit
import ChameleonFramework

class CategoryViewController: SwipeTableViewController{
    
    var categories: Results<Category>?
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BigTitleNavigationBar(title: "Todoey")
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addCategoryButtonPressed)
        )

        tableView.register(SwipeTableViewCell.self, forCellReuseIdentifier: "CategoryCell")

        loadCategories()
    }
    
    //MARK: - DataSource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return categories?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        super.identifierOfCell = "CategoryCell"
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        let customTextLabel = cell.textLabel
        customTextLabel?.text = categories?[indexPath.row].name ?? "No Category added yet"
        customTextLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        customTextLabel?.textColor = UIColor(hexString: categories?[indexPath.row].colorOfCategory ?? "000000")
        customTextLabel?.layer.shadowColor = UIColor(
            hexString: categories?[indexPath.row].colorOfCategory ?? "000000"
        )?.darken(byPercentage: 0.11)?.cgColor

        customTextLabel?.layer.shadowRadius = 1.8
        customTextLabel?.layer.shadowOpacity = 0.55
        customTextLabel?.layer.shadowOffset = CGSize(width: 0.05, height: 0.05)
//        cell.backgroundColor = UIColor(hexString: categories?[indexPath.row].colorOfCategory ?? "FFFFFF")
        return cell
    }
    
    //MARK: - Add New Cetegories
    
    @objc func addCategoryButtonPressed(_ sender: UIBarButtonItem){
        let alert = UIAlertController(
            title: "Add New Category",
            message: nil,
            preferredStyle: .alert
        )
        var textFieldAlert = UITextField()
        let action = UIAlertAction(
            title: "Add Category",
            style: .default) { action in
                let newCategroy = Category()
                newCategroy.name            = textFieldAlert.text!
                newCategroy.colorOfCategory = UIColor.randomFlat().hexValue()
                
                self.save(category: newCategroy)
            }
        alert.addTextField { textField in
            textField.placeholder = "Name the new category"
            textFieldAlert = textField
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    //MARK: - TabView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todoVC = TodoListViewController()
        todoVC.selectedCategory = categories?[indexPath.row]
        self.navigationController?.pushViewController(todoVC, animated: true)

    }

    //MARK: - Data Operations Methods
    
    func save(category: Object){
        do{
            try realm.write({
                realm.add(category)
            })
        } catch {
            print("Error Saving Data \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories (){
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        do{
            try realm.write({
                if let categoryForDelection = categories?[indexPath.row]{
                    realm.delete(categoryForDelection)
                }
            })
        } catch {
            print("Error with deleting \(error)")
        }
    }
}
