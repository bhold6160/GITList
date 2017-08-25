//
//  AllListsViewController.swift
//  GITList
//
//  Created by Brandon Holderman on 8/23/17.
//  Copyright © 2017 Brandon Holderman. All rights reserved.
//

import UIKit

class AllListsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var allLists = [List]()
    
    @IBOutlet weak var allListsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.allListsTable.dataSource = self
        self.allListsTable.delegate = self
        
        let nib = UINib(nibName: "ListCell", bundle: nil)
        self.allListsTable.register(nib, forCellReuseIdentifier: "listCell")
        
        self.allListsTable.rowHeight = UITableViewAutomaticDimension
        self.allListsTable.estimatedRowHeight = 50
        
}
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        CloudKit.shared.getList { (userList) in
            if let userList = userList {
                OperationQueue.main.addOperation {
                    self.allLists = userList
                    self.allListsTable.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListCell
        
        let currentList = self.allLists[indexPath.row]
        
        cell.list = currentList
        
        return cell
    }
}
