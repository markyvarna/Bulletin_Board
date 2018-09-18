//
//  Message.swift
//  BulletinBoard
//
//  Created by Markus Varner on 9/17/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import Foundation
import CloudKit

class Message {
    
    //the key is static so we can access it to fetch objects from cloud within model controller
    static let TypeKey = "Message"
    private let TextKey = "text"
    private let TimeStampKey = "timeStamp"
    
    
    let text: String
    let timeStamp: Date
    /*note: normally if we were planning to store our data anywhere else besides CloudKit,
     we would have to convert the timeStamp Date to the number of seconds since 1970*/
    
    
    init(text: String, timeStamp: Date = Date()){
        
        self.text = text
        self.timeStamp = timeStamp
        
    }
    
    //MARK: - Failable Init
    //pull the values out of the record if there are any values at all, and set them as the values of the model obj
    init?(cloudKitRecord: CKRecord) {
        
        guard let text = cloudKitRecord[TextKey] as? String,
            let timeStamp = cloudKitRecord[TimeStampKey] as? Date else {return nil}
        self.text = text
        self.timeStamp = timeStamp
        
    }
    
    //MARK: - CloudKit Record Setup
    //1) Import CloudKit
    //2) Make a Key that represents Message Obj (in this case static)
    //3) Make Keys for the Message Obj Properties (private is fine)
    //4)Assign Key as cloudKitRecord Type
    //5) Set Values
    //6) Return Record
    
    var cloudKitRecord: CKRecord {
        
        let record = CKRecord(recordType: Message.TypeKey)
        record.setValue(text, forKey: TextKey)
        record.setValue(timeStamp, forKey: TimeStampKey)
        return record
        
    }
    
    
}
