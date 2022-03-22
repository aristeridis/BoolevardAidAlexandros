//
//  Me.swift
//  MyChatApp
//
//  Created by Alexandros on 13/2/18.
//  Copyright © 2018 Alexandros. All rights reserved.
//

import Foundation
import FirebaseAuth

class Me {

    static var uid: String {
    
    return (Auth.auth().currentUser?.uid)!
        
    }


}
