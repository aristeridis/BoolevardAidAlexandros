//
//  Decorator.swift
//  MyChatApp
//
//  Created by Alexandros on 13/1/18.
//  Copyright © 2018 Alexandros. All rights reserved.
//

import Foundation
import Chatto
import ChattoAdditions

class Decorator: ChatItemsDecoratorProtocol {

    
    func decorateItems(_ chatItems: [ChatItemProtocol]) -> [DecoratedChatItem] {
        var decoratedItems = [DecoratedChatItem]()
        
        for (index, item) in chatItems.enumerated() {
            
        let nextMessage: ChatItemProtocol? = (index + 1 < chatItems.count) ? chatItems[index + 1] : nil
        let bottomMargin = separationAfterItem(current: item, next: nextMessage)
        let decoratedItem = DecoratedChatItem (chatItem: item, decorationAttributes: ChatItemDecorationAttributes(bottomMargin: bottomMargin, showsTail: false, canShowAvatar: false))
        decoratedItems.append(decoratedItem)
        }
        
        return decoratedItems
        
    }
    
    func separationAfterItem(current: ChatItemProtocol?,next: ChatItemProtocol?) -> CGFloat {
    
        guard let next = next else { return 0 }
        
        let currentMessage = current as? MessageModelProtocol
        let nextMessage = next as? MessageModelProtocol
        
        if currentMessage?.senderId != nextMessage?.senderId {
            return 10
        } else {
            
        return 3
        
        }
    
    }
}

