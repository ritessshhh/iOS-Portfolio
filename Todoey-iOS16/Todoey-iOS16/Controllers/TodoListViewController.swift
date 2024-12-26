//
//  ViewController.swift
//  Todoey-iOS16
//
//  Created by ritessshhh on 18/06/2023.
//
//

import UIKit
import RealmSwift
import ChameleonFramework

class TodoListViewController: SwipeTableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var todoItems : Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory: Category? {
        didSet{
            loadItems()
            title = selectedCategory!.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        let search = UISearchController(searchResultsController: nil)
//        search.delegate = self
//        search.searchBar.delegate = self
//        self.navigationItem.searchController = search
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let colorOfCategory = selectedCategory?.bgColorOfCategory {
            guard let navBar = navigationController?
                .navigationBar else {fatalError("Navigation controller not exist yet")}
            if let navBarColor = UIColor(hexString: colorOfCategory) {
                
                
//                navBar.backgroundColor           = navBarColor
                navBar.barTintColor              = navBarColor
                navBar.tintColor                 = ContrastColorOf(navBarColor, returnFlat: true)
                navBar.largeTitleTextAttributes  = [
                    .foregroundColor : ContrastColorOf(navBarColor, returnFlat: true)
                ]
                navBar.titleTextAttributes = [
                    .foregroundColor : ContrastColorOf(navBarColor, returnFlat: true)
                ]
                view.backgroundColor = navBarColor
                searchBar.barTintColor = navBarColor
                
            }
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        guard let navBar = navigationController?
            .navigationBar else {fatalError("Navigation controller not exist yet")}
        navBar.barTintColor = UINavigationController().navigationBar.barTintColor
        navBar.tintColor    = UIColor.tintColor
        
        navBar.largeTitleTextAttributes  = [
            .foregroundColor : UIColor.label
        ]
        navBar.titleTextAttributes = [
            .foregroundColor : UIColor.label
        ]
    }
    
    //MARK: - TableView DataSource Methods
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        super.identifierOfCell = "ToDoItemCell"
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
//        let cell = tableView
//            .dequeueReusableCell(
//                withIdentifier: "ToDoItemCell",
//                for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            if let color = UIColor(hexString: selectedCategory!.bgColorOfCategory)?
                .darken(byPercentage:
                            CGFloat(indexPath.row)/CGFloat(todoItems!.count)
                ) {
                cell.backgroundColor = color
                cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
            }
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
            
        } else {
            
            cell.textLabel?.text = "No items added yet"
        }
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        
        if let item = todoItems?[indexPath.row] {
            do{
                try realm.write({
                    //                    realm.delete(item)
                    item.done = !item.done
                })
                
            } catch {
                print("Error saving \(error)")
            }
        }
        tableView.reloadData()
        //        let item = todoItems?[indexPath.row]
        //        How to Delete Items : 👇🏻
        //        context.delete(item)
        //        itemArray.remove(at: indexPath.row)
        
        //        item.done = !item.done
        tableView.deselectRow(at: indexPath, animated: true)
        
        //        saveData()
    }
    
    //MARK: - Add Item
    
    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        var textfieldOfAlert = UITextField()
        
        let alert = UIAlertController(
            title: "Add New ToDo Item",
            message: "",
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(
            title: "Add Item",
            style: .default) { [self] action in
                
                if  let currentCategory = self.selectedCategory {
                    do {
                        try self.realm.write{
                            let newItem = Item()
                            newItem.title = textfieldOfAlert.text!
                            newItem.dateCreated = Date()
                            
                            currentCategory.items.append(newItem)
                        }
                    } catch {
                        print("Error saving with Realm \(error)")
                    }
                }
                self.tableView.reloadData()
            }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create New Item"
            textfieldOfAlert = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    //MARK: - Saving data to DB by using CoreData
    
    //    func saveData(){
    //        do {
    //            try context.save()
    //        } catch {
    //            print("Error Saving context \(error)")
    //        }
    //        self.tableView.reloadData()
    //    }
    
    //MARK: - Reading/Loading data from DB by using CoreData
    func loadItems(
        
    ){
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
        //        let categoryPredicate = NSPredicate(
        //            format: "parentCategory.name MATCHES %@", selectedCategory!.name!
        //        )
        //
        //        if let additionalPredicate = predicate {
        //
        //            request.predicate = NSCompoundPredicate(
        //                andPredicateWithSubpredicates: [
        //                    additionalPredicate,
        //                    categoryPredicate
        //                ]
        //            )
        //
        //        } else {
        //            request.predicate = categoryPredicate
        //        }
        //
        //        do {
        //            itemArray = try context.fetch(request)
        //        } catch {
        //            print("Error with Fetching data By CoreData \(error)")
        //        }
    }
    
    override func updateModel(at indexPath: IndexPath) {
        do {
            print("\n ============= Overrided Update work ============== \n")
            try self.realm.write {
                if let categoryForDeletion = self.todoItems?[indexPath.row] {
                    self.realm.delete(categoryForDeletion)
                }
            }
        } catch {
            print("Error with deleting \(error)")
        }
    }
}

//MARK: - Search Bar Methods

extension TodoListViewController: UISearchBarDelegate,UISearchControllerDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        todoItems = todoItems?
            .filter("title CONTAINS[cd] %@", searchBar.text!)
            .sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
        
        
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        loadItems(with: request, predicate: predicate)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
