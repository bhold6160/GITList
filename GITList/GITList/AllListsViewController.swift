//
//  AllListsViewController.swift
//  GITList
//
//  Created by Brandon Holderman on 8/23/17.
//  Copyright © 2017 Brandon Holderman. All rights reserved.
//

import UIKit

class AllListsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var allList = [List]()
    
    @IBOutlet weak var allListsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.allListsTable.dataSource = self
        self.allListsTable.delegate = self
        
        let nib = UINib(nibName: "ListCell", bundle: nil)
        self.allListsTable.register(nib, forCellReuseIdentifier: "listCell")
        
        self.allListsTable.rowHeight = UITableViewAutomaticDimension
        self.allListsTable.estimatedRowHeight = 75
        
        CloudKit.shared.getList { (userList) in
            if let userList = userList {
            OperationQueue.main.addOperation {
                self.allList = userList
                self.allListsTable.reloadData()
            }
        }
    }
}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListCell
        
        let currentList = self.allList[indexPath.row]
        
        cell.list = currentList
        
        return cell
    }
}
