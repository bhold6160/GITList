//
//  ListService.swift
//  GITList
//
//  Created by Brandon Holderman on 8/23/17.
//  Copyright © 2017 Brandon Holderman. All rights reserved.
//

import Foundation
import CloudKit

class ListService {
    
    static let shared = ListService()
    
    var listArray = [[List]]()
    
    func record() throws -> CKRecord? {
        
        let listRecord = CKRecord(recordType: "List")
        listRecord["listArray"] = self.listArray as CKRecordValue
        
        return listRecord
    }
}
