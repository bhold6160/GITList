//
//  Cloudkit.swift
//  GITList
//
//  Created by Louis W. Haywood on 8/23/17.
//  Copyright © 2017 Brandon Holderman. All rights reserved.
//

import Foundation
import CloudKit

typealias ListCompletion = (Bool)->()
typealias GetListCompletion = ([List]?)->()

class CloudKit {
    static let shared = CloudKit()
    let container = CKContainer.default()
    var database : CKDatabase {
        return container.privateCloudDatabase
    }
    
    private init (){}
 
    func save(list: List, completion: @escaping ListCompletion) {
        do {
            if let record = try list.record() {
                self.database.save(record, completionHandler: { (record, error) in
                    if error != nil {
                        print(error!)
                        completion(false)
                    }
                    
                    if let record = record {
                        print(record)
                        completion(true)
                    }
                    
                })
            }
        } catch {
            print(error)
        }
    }
    
    func getList(completion:  @escaping GetListCompletion) {
        let query = CKQuery(recordType: "List", predicate: NSPredicate(value: true))
        
        self.database.perform(query, inZoneWith: nil) { (records, error) in
            if error != nil {
                print(error!.localizedDescription)
                completion(nil)
            }
            if let records = records {
                var allLists = [List]()
    
                for record in records {
                    guard let recordValue = record["items"] as? [String] else { continue }
                    
            
                    let newList = List()
                    newList.items = recordValue
                    allLists.append(newList)
                }
                
                OperationQueue.main.addOperation {
                    completion(allLists)
                }
                completion(nil)
            }
        }
    }
}
