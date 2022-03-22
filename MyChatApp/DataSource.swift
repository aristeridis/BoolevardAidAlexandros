//
//  DataSource.swift
//  MyChatApp
//
//  Created by Alexandros on 13/1/18.
//  Copyright © 2018 Alexandros. All rights reserved.
//

import Foundation
import Chatto
import ChattoAdditions


class DataSource : ChatDataSourceProtocol{

    weak var delegate: ChatDataSourceDelegateProtocol?
    
    var controller = ChatItemsController()
    var currentlyLoading = false
    
    init(initialMessages:[ChatItemProtocol], uid: String) {
        self.controller.initialMessages = initialMessages
        self.controller.userUID = uid
        self.controller.loadIntoItemsArray(messagesNeeded: min(initialMessages.count, 50),moreToLoad: initialMessages.count > 50)
        NotificationCenter.default.addObserver(self, selector: #selector(updateLoadingPhoto), name: NSNotification.Name(rawValue: "updateImage"), object: nil)
        }
    
    var chatItems: [ChatItemProtocol]  {//the messages that show up in the collection view
    
    return controller.items
        
    }

    var hasMoreNext: Bool{
    
    return false
    }
    var hasMorePrevious: Bool{
        
  return controller.loadMore
    
    }
    func loadNext() {
        
    }
    func loadPrevious() {
        if currentlyLoading == false {
            currentlyLoading = true
        controller.loadPrevious(){//it goes to ChatItemController  loadPrevious first and after here for the delagate
 self.delegate?.chatDataSourceDidUpdate(self, updateType: .pagination)
            self.currentlyLoading = false
        }
    }
    }
      func addMessage(message: ChatItemProtocol){
        self.controller.insertItem(message: message)
        self.delegate?.chatDataSourceDidUpdate(self)
        
    }
    
    func updateTextMessage(uid: String, status: MessageStatus){
        if let index = self.controller.items.index(where: { (message) -> Bool in
            return message.uid == uid
        }) {
            let message = self.controller.items[index] as! TextModel
            message.status = status
            self.delegate?.chatDataSourceDidUpdate(self)
        }
    
        
    }
    func updatePhotoMessage(uid: String, status: MessageStatus){
        if let index = self.controller.items.index(where: { (message) -> Bool in
            return message.uid == uid
        }) {
            let message = self.controller.items[index] as! PhotoModel
            message.status = status
            self.delegate?.chatDataSourceDidUpdate(self)
        }
        
        
    }
    @objc func updateLoadingPhoto(notification: Notification) {
        let info = notification.userInfo as! [String: Any]
        let image = info["image"] as! UIImage
        let uid = info["uid"] as! String
        if let index = self.controller.items.index(where: { (message) -> Bool in
            return message.uid == uid
        }) {
        let item = self.controller.items[index] as! PhotoModel
            let model = MessageModel(uid: item.uid, senderId: item.senderId, type: item.type, isIncoming: item.isIncoming, date: item.date, status: item.status)
            let photoMessage = PhotoModel(messageModel: model, imageSize: image.size, image: image)
            self.controller.items[index] = photoMessage
            self.delegate?.chatDataSourceDidUpdate(self)
            
           }

            }
    
    func adjustNumberOfMessages(preferredMaxCount: Int?, focusPosition: Double, completion: (Bool) -> Void) {
        if focusPosition > 0.9{
        self.controller.adjustWindow()//auto pagination
        completion(true)
        }
        else {
            completion(false)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "updateImage"), object: nil)
    }

}
