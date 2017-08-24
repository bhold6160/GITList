//
//  ViewController.swift
//  GITList
//
//  Created by Brandon Holderman on 8/21/17.
//  Copyright © 2017 Brandon Holderman. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var userList = [List]() {
        didSet {
            listTableView.reloadData()
        }
    }
    
    @IBOutlet weak var listTableView: UITableView!
    
    @IBAction func addNewItem(_ sender: Any) {
        itemTextField.resignFirstResponder()
        
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

