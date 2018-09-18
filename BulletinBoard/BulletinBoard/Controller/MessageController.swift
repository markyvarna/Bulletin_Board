//
//  MessageController.swift
//  BulletinBoard
//
//  Created by Markus Varner on 9/17/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import Foundation
import CloudKit

class MessageController {
    
    //shared instances
    static let shared = MessageController()
    
    let messagesWereUpdatedNotification = Notification.Name("messagesWereUpdated")
    
    //source of truth & property observer
    var messages: [Message] = [] {
        didSet{
            NotificationCenter.default.post(name: messagesWereUpdatedNotification, object: nil)
        }
    }
    
    func saveMessageRecordToiCloudWith(text: String) {
       
       // init new message obj
        let message = Message(text: text)
        //use saveRecordTo() method to save obj's CKRecord
        CloudKitManager.sharedManager.saveRecordToCloudKit(record: message.cloudKitRecord, database: CKContainer.default().publicCloudDatabase) { (error) in
            //check for errors
            if let error = error {
                print("💩 Friggin Error Saving Record to iCloud \(error.localizedDescription)💩")
            } else {
                //append the message to the message array
                self.messages.append(message)
        
            }
        }
        
        
    }
    
    //MARK: - Fetch Messages Func
    func fetchMessagesFromiCloud() {
        
        
            //use cloudkitmanager fetchRecordOf() method to fetch records from right database
            CloudKitManager.sharedManager.fetchRecordOf(type: Message.TypeKey, database: CKContainer.default().publicCloudDatabase) { (records, error) in
            //check for errors
            if let error = error {
            print("🤮Friggin Error \(error.localizedDescription) 💩")
            }
            //take records that are returned and intialize message objects
                guard let records = records else {return}
            let messages = records.compactMap({ Message(cloudKitRecord: $0) })
            //set newly created objs in the source of truth array
            self.messages = messages
        
            }
        }
    
}




