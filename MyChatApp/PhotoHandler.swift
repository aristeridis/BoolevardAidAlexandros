//
//  PhotoHandler.swift
//  MyChatApp
//
//  Created by Alexandros on 16/1/18.
//  Copyright © 2018 Alexandros. All rights reserved.
//

import Foundation
import Chatto
import ChattoAdditions

class PhotoHandler: BaseMessageInteractionHandlerProtocol{
    
    func userDidTapOnFailIcon(viewModel: photoViewModel, failIconView: UIView) {
        print("tap on fail")
    }
    func userDidTapOnAvatar(viewModel: photoViewModel) {
        print("tap on avatar")
        
    }
    func userDidTapOnBubble(viewModel: photoViewModel) {
        //print(photoViewModel)
        print("tap on bubble")
        
    }
    func userDidBeginLongPressOnBubble(viewModel: photoViewModel) {
        print("beeing long press")
        
    }
    func userDidEndLongPressOnBubble(viewModel: photoViewModel) {
        print("end long press")
        
    }
    
    
}
