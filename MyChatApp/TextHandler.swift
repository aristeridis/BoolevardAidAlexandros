//
//  TextHandler.swift
//  MyChatApp
//
//  Created by Alexandros on 15/1/18.
//  Copyright © 2018 Alexandros. All rights reserved.
//

import Foundation
import Chatto
import ChattoAdditions


class TextHandler: BaseMessageInteractionHandlerProtocol{

    func userDidTapOnFailIcon(viewModel: ViewModel, failIconView: UIView) {
        print("tap on fail")
    }
    func userDidTapOnAvatar(viewModel: ViewModel) {
        print("tap on avatar")

    }
    func userDidTapOnBubble(viewModel: ViewModel) {
        print(viewModel.text)
        print("tap on bubble")
        
    }
    func userDidBeginLongPressOnBubble(viewModel: ViewModel) {
        print("beeing long press")

    }
    func userDidEndLongPressOnBubble(viewModel: ViewModel) {
        print("end long press")
        
    }


}
