//
//  ViewController.swift
//  GITList
//
//  Created by Brandon Holderman on 8/21/17.
//  Copyright © 2017 Brandon Holderman. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var userList = List()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var listTableView: UITableView!
    
    @IBAction func addNewItem(_ sender: Any) {
        itemTextField.resignFirstResponder()
        
        if (itemTextField.text != "") {
            
            userList.items.append(itemTextField.text!)
            print(userList.items)
            listTableView.reloadData()
            itemTextField.text = ""
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        self.activityIndicator.startAnimating()
            CloudKit.shared.save(list: userList, completion: { (success) in
                if success {
                    self.performSegue(withIdentifier: "saveSegue", sender: nil)
                    self.activityIndicator.stopAnimating()
                    print("Successfully saved to the cloud")
                } else {
                    print("Unsuccessful in saving to cloud")
                }
            })
        }
    
    @IBOutlet weak var itemTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        listTableView.reloadData()
    }
    
    func listController(didSelect items: [String]) {
        self.userList.items = items
        self.tabBarController?.selectedIndex = 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        cell.textLabel?.text = userList.items[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            userList.items.remove(at: indexPath.row)
            listTableView.reloadData()
        }
    }
}

