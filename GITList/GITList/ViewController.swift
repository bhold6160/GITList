//
//  ViewController.swift
//  GITList
//
//  Created by Brandon Holderman on 8/21/17.
//  Copyright © 2017 Brandon Holderman. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var userList = ["Do something", "do something else", "do more stuff", "And more"] {
        didSet {
            listTableView.reloadData()
        }
    }
    
    @IBOutlet weak var listTableView: UITableView!
    
    @IBAction func addNewItem(_ sender: Any) {
        itemTextField.resignFirstResponder()
//        listCell = itemTextField.text
        
        if (itemTextField.text != "") {
            
            userList.append(itemTextField.text!)
            itemTextField.text = ""
        }
    }
    
    @IBOutlet weak var itemTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        CloudKit.shared.getList {(list) in
            if let list = list {
                print(list)
                self.userList = list
            }
        }
        listTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        cell.textLabel?.text = userList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            userList.remove(at: indexPath.row)
            listTableView.reloadData()
        }
    }
}

