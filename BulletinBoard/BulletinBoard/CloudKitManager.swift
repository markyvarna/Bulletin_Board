//
//  CloudKitManager.swift
//  BulletinBoard
//
//  Created by Markus Varner on 9/17/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import Foundation
import CloudKit

class CloudKitManager {
    
    //shared manager
    static let sharedManager = CloudKitManager()
    
    //MARK: - Save Record Func
    
    func saveRecordToCloudKit(record: CKRecord, database: CKDatabase, completion: @escaping (Error?) -> Void = {_ in }) {
        
        database.save(record) { (_, error) in
            completion(error)
        }
        
    }
    
    
    //MARK: - Fetch Record of Type
    
//    func fetchRecordOf(type: String, database: CKDatabase, completion: @escaping ([CKRecord], Error?) -> Void) {
//
//        //set a filter for search of what we want, in the case we are saying if there is any record at all then fetch it
//        let predicate = NSPredicate(value: true)
//        //make a query
//        let query = CKQuery(recordType: Message.TypeKey, predicate: predicate)
//        //give cloudkit the query now
//        database.perform(query, inZoneWith: nil, completionHandler: completion as! ([CKRecord]?, Error?) -> Void)
//
//    }
    func fetchRecordOf(type: String, database: CKDatabase, completion: @escaping ([CKRecord]?, Error?) -> Void) {
        let predicate =  NSPredicate(value: true)
        let query = CKQuery(recordType: Message.TypeKey, predicate: predicate)
        database.perform(query, inZoneWith: nil, completionHandler: completion)
    }
}
