//
//  HomeViewController.swift
//  GITList
//
//  Created by Brandon Holderman on 8/22/17.
//  Copyright © 2017 Brandon Holderman. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var allLists = [List]()
    
    @IBOutlet weak var homeTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.homeTableView.dataSource = self
        self.homeTableView.delegate = self
        
        let nib = UINib(nibName: "ListCell", bundle: nil)
        self.homeTableView.register(nib, forCellReuseIdentifier: "listCell")
        
        self.homeTableView.rowHeight = UITableViewAutomaticDimension
        self.homeTableView.estimatedRowHeight = 50
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        CloudKit.shared.getList { (userList) in
            if let userList = userList {
                OperationQueue.main.addOperation {
                    self.allLists = userList
                    self.homeTableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        performSegue(withIdentifier: "showAllList", sender: nil)
    }
}
