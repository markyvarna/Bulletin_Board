//
//  MessageListTableVC.swift
//  BulletinBoard
//
//  Created by Markus Varner on 9/17/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit

class MessageListTableVC: UITableViewController {

    //MARK: - Outlets
    
    @IBOutlet var messageTextField: UITextField!
    
    
     //MARK: - Properties
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: MessageController.shared.messagesWereUpdatedNotification, object: nil)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        MessageController.shared.fetchMessagesFromiCloud()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        return MessageController.shared.messages.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)

        let message = MessageController.shared.messages[indexPath.row]
        cell.textLabel?.text = message.text
        cell.detailTextLabel?.text = dateFormatter.string(from: message.timeStamp)
        

        return cell
    }
    
    //MARK: - Actions
    
    @IBAction func postButtonPressed(_ sender: UIButton) {
        
        guard let messageText  = messageTextField.text else {return}
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        MessageController.shared.saveMessageRecordToiCloudWith(text: messageText)
    }
    
    @objc   func refresh() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
}
