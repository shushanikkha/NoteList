//
//  NoteListTableViewCell.swift
//  NoteList
//
//  Created by Shushan Khachatryan on 6/20/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit

protocol SendEmailDelegate: class {
    func sendEmail(email: String )
}

class NoteListTableViewCell: UITableViewCell {
    
    weak var delegate: SendEmailDelegate?
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet private weak var noteImage: UIImageView?
    
    @IBAction func emailAction() {
        delegate?.sendEmail(email: emailLabel.text ?? "")
    }

    
    // MARK: - Method -
    
    func update (with note: NoteList) {
        titleLabel.text = note.title
        descriptionLabel.text = note.description
        emailLabel.text = note.email
        phoneNumberLabel.text = note.phoneNumber
        if let noteImage = self.noteImage {
            noteImage.image = note.image
        }
    }

}
