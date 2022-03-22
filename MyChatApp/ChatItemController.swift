//
//  ChatItemController.swift
//  MyChatApp
//
//  Created by Alexandros on 13/1/18.
//  Copyright © 2018 Alexandros. All rights reserved.
//

import Foundation
import Chatto
import ChattoAdditions
import FirebaseDatabase
import SwiftyJSON

class ChatItemsController: NSObject {
    
    var items = [ChatItemProtocol]()//controls at DataSource file var chatItems
    var initialMessages = [ChatItemProtocol]()
    var loadMore = false
    var userUID : String!
    typealias completeLoading = () -> Void
    
    func loadIntoItemsArray(messagesNeeded:Int,moreToLoad: Bool) {
    
        for index in stride(from: initialMessages.count - items.count, to: initialMessages.count - items.count - messagesNeeded, by: -1){
                self.items.insert(initialMessages[index - 1], at: 0)
            self.loadMore = moreToLoad
        }
    
    
    }
    func insertItem(message: ChatItemProtocol){
    
    self.items.append(message)
    }
    func loadPrevious(Completion: @escaping completeLoading){
        Database.database().reference().child("User-messages").child(Me.uid).child(userUID).queryEnding(atValue: nil, childKey: self.items.first?.uid).queryLimited(toLast: 52).observeSingleEvent(of: .value, with: { [weak self] (snapshot) in
            var messages = Array(JSON(snapshot.value as Any).dictionaryValue.values).sorted(by: { (lhs, rhs) -> Bool in
                return lhs["date"].doubleValue < rhs["date"].doubleValue
            })
            messages.removeLast()
            self?.loadMore = messages.count > 50
            let converted = self!.convertToChatItemProtocol(messages: messages)
            for index in stride(from: converted.count, to: converted.count - min(messages.count, 50), by: -1) {
            self?.items.insert(converted[index - 1], at: 0)
            }
            Completion()
            messages.filter({ (message) -> Bool in
                return message["type"].stringValue == PhotoModel.chatItemType
            }).forEach({ (message) in
                self?.parseURLs(UID_URL: (key: message["uid"].stringValue, value: message["image"].stringValue))
            })
        })
        
    
    }
    func adjustWindow(){
        self.items.removeFirst(200)
        self.loadMore = true//it must be always true to paginate
    }
}
