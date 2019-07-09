//
//  NoteList.swift
//  NoteList
//
//  Created by Shushan Khachatryan on 6/20/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import Foundation
import UIKit



class NoteList {
    var title: String
    var description: String
    var email: String
    var phoneNumber: String
    var date: Date
    var image: UIImage?
    
    init(title: String, description: String, email: String, phoneNumber: String, date: Date, image: UIImage? = nil) {
        self.title = title
        self.description = description
        self.email = email
        self.phoneNumber = phoneNumber
        self.date = date
        self.image = image
    }
    
}
