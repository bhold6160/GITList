//
//  List.swift
//  GITList
//
//  Created by Brandon Holderman on 8/22/17.
//  Copyright © 2017 Brandon Holderman. All rights reserved.
//

import UIKit
import CloudKit

enum RecordError: Error {
    case writingListToData
    case writingDataToDisk
}

class List {
    var items = [String]()
    
    func record() throws -> CKRecord? {
            
            let listRecord = CKRecord(recordType: "List")
        
            listRecord["items"] = self.items as CKRecordValue
            
            return listRecord
        }
    }

