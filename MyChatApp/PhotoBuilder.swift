//
//  PhotoBuilder.swift
//  MyChatApp
//
//  Created by Alexandros on 16/1/18.
//  Copyright © 2018 Alexandros. All rights reserved.
//

import Foundation
import Chatto
import ChattoAdditions

class photoViewModel: PhotoMessageViewModel<PhotoModel>{

  override init(photoMessage: PhotoModel, messageViewModel: MessageViewModelProtocol) {
        super.init(photoMessage: photoMessage, messageViewModel: messageViewModel)
    }




}
class PhotoBuilder: ViewModelBuilderProtocol{
    let defaultBuilder = MessageViewModelDefaultBuilder()
    func canCreateViewModel(fromModel decoratedPhotoMessage: Any) -> Bool {
        return decoratedPhotoMessage is PhotoModel
    }
    func createViewModel(_ decoratedPhotoMessage: PhotoModel) -> photoViewModel {
    let photoMessageViewModel = photoViewModel(photoMessage: decoratedPhotoMessage, messageViewModel: defaultBuilder.createMessageViewModel(decoratedPhotoMessage))
       return photoMessageViewModel
    }




}
