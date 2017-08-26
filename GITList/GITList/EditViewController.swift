//
//  EditViewController.swift
//  GITList
//
//  Created by Brandon Holderman on 8/26/17.
//  Copyright © 2017 Brandon Holderman. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var userList = List()
    
    @IBOutlet weak var editTableView: UITableView!
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func addNewItem(_ sender: Any) {
        itemTextField.resignFirstResponder()
        if (itemTextField.text != "") {
            
            userList.items.append(itemTextField.text!)
            print(userList.items)
            editTableView.reloadData()
            itemTextField.text = ""
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        self.activityIndicator.startAnimating()
        CloudKit.shared.save(list: userList, completion: { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
                self.activityIndicator.stopAnimating()
                print("Successfully saved to the cloud")
            } else {
                print("Unsuccessful in saving to cloud")
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.editTableView.dataSource = self
        self.editTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        cell.textLabel?.text = userList.items[indexPath.row]
        
        return cell
    }
}
