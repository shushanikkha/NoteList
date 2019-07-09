//
//  AddViewController.swift
//  NoteList
//
//  Created by Shushan Khachatryan on 6/20/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit


protocol AddViewControllerDelegate: class {
    func noteCreated(note: NoteList)
}

class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageChooseButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIBarButtonItem!
//    var isEdit: Bool {
//        didSet {
//            
//        }
//    }
    var note: NoteList?
    weak var delegate: AddViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTextView.layer.cornerRadius = 6.0
        descriptionTextView.layer.borderWidth = 0.5
        descriptionTextView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        
//        if let note = self.note {
//            titleTextField.text = note.title
//            descriptionTextView.text = note.description
//            emailTextField.text = note.email
//            phoneNumberTextField.text = note.phoneNumber
//            datePicker.date = note.date
//            imageView.image = note.image
//        }
   //    updateSaveButtonState()
    } 
    
//    func updateSaveButtonState() {
//        if  let titleText = titleTextField.text, let descriptionText = descriptionTextView.text, let phoneNumber = phoneNumberTextField.text, let email = emailTextField.text  {
//            let note = NoteList(title: titleText, description: descriptionText, email: email, phoneNumber: phoneNumber, image: imageView.image)
//            delegate?.noteCreated(note: note)
//
//        }
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
//
//        guard segue.identifier == "saveNotes" else { return }
//        if let title = titleTextField.text, let description = descriptionTextView.text, let phoneNumber = phoneNumberTextField.text, let email = emailTextField.text  {
//            self.note = NoteList(title: title, description: description, email: email, phoneNumber: phoneNumber, image: imageView.image)
//            delegate?.noteCreated(note: note!)
//        }
//    }
    

    
  //   MARK: - IBActions

//    @IBAction func textEditingChanged(_ sender: Any) {
//        updateSaveButtonState()
//    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        if let title = titleTextField.text, let description = descriptionTextView.text, let phoneNumber = phoneNumberTextField.text, let email = emailTextField.text, let date = datePicker {
            if !email.isValidEmail {
                let alert = UIAlertController(title: "Unvalid Email!", message: "Please, check your email, it must be at this form: example@gmail.com", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(okAction)
                present(alert, animated: true, completion:  nil)
            } else if !phoneNumber.isValidPhone {
                let alert = UIAlertController(title: "Unvalid phone number!", message: "Please, check your phone number, it must be at this form: 000-000000", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(okAction)
                present(alert, animated: true, completion:  nil)
            } else {
            let note = NoteList(title: title, description: description, email: email, phoneNumber: phoneNumber, date: date.date, image: imageView.image)
            delegate?.noteCreated(note: note)
            navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    }
    
    @IBAction func chooseImage(_ sender: UIButton) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { action in
                                imagePicker.sourceType = .camera
                                self.present(imagePicker, animated: true, completion: nil)
        })
        alertController.addAction(cameraAction)
        }
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: { action in
                                imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
    })
        alertController.addAction(photoLibraryAction)
        }
        
        present(alertController, animated: true, completion:  nil)
        
    }
    
    // MARK: - UIImagePickerControllerDelegate -
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pickedImage = info[.originalImage] as? UIImage else { return }
        self.imageView.image = pickedImage
        picker.dismiss(animated: true, completion: nil)
    }
    

    
    
}
