//
//  MessagesTableViewCell.swift
//  MyChatApp
//
//  Created by Alexandros on 28/1/18.
//  Copyright © 2018 Alexandros. All rights reserved.
//

import UIKit

class MessagesTableViewCell: UITableViewCell {

    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var lastMessageDate: UILabel!
    @IBOutlet weak var lastMessage: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    deinit {
        print("deinit TableViewcell")
    }

}
