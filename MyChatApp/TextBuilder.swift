//
//  TextBuilder.swift
//  MyChatApp
//
//  Created by Alexandros on 15/1/18.
//  Copyright © 2018 Alexandros. All rights reserved.
//

import Foundation
import Chatto
import ChattoAdditions

class ViewModel: TextMessageViewModel<TextModel>{
    
    override init (textMessage: TextModel,messageViewModel: MessageViewModelProtocol){
     super.init(textMessage: textMessage, messageViewModel: messageViewModel)
        
        
    }
    }



class TextBuilder: ViewModelBuilderProtocol {
    
    let defaultBuilder = MessageViewModelDefaultBuilder()

    func canCreateViewModel(fromModel decoratedTextMessage: Any) -> Bool {
        return decoratedTextMessage is TextModel
    }
    func createViewModel(_ decoratedTextMessage: TextModel) -> ViewModel {
        let textMessageViewModel = ViewModel(textMessage: decoratedTextMessage, messageViewModel: defaultBuilder.createMessageViewModel(decoratedTextMessage))
        return textMessageViewModel
        
    }







}
