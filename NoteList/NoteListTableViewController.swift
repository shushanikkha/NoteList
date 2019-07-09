//
//  NoteListTableViewController.swift
//  NoteList
//
//  Created by Shushan Khachatryan on 6/20/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit
import SafariServices
import MessageUI

class NoteListTableViewController: UITableViewController, AddViewControllerDelegate, SendEmailDelegate,
MFMailComposeViewControllerDelegate {

   
    
   private var notes = [NoteList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200.0
        title = "Notes List"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = notes[indexPath.row]
        var reuseIdentifier = "NoteListTableViewCell"
        if note.image != nil {
            reuseIdentifier = "ImageNoteListTableViewCell"
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? NoteListTableViewCell else { return UITableViewCell() }
        cell.update(with: note)
        cell.delegate = self
        return cell
    }
 
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let moveNote = notes.remove(at: fromIndexPath.row)
        notes.insert(moveNote, at: to.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    // MARK: - IBAction
    
    @IBAction func editButton(_ sender: UIBarButtonItem) {
        let tableViewEditingMode = tableView.isEditing
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }
    
    
    @IBAction private func addAction(){
        guard let addViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddViewController") as? AddViewController else { return }
        addViewController.delegate = self
        let navVC = UINavigationController(rootViewController: addViewController)
        present(navVC, animated: true, completion: nil)
        
    }
 
    
    @IBAction func unwindToNoteListView(segue: UIStoryboardSegue) {
//        guard segue.identifier == "saveNotes" else { return }
//        let sourceViewController = segue.source as! AddViewController
//        if let note = sourceViewController.note {
//            if let selectedIndexPath = tableView.indexPathForSelectedRow {
//                notes[selectedIndexPath.row] = note
//                tableView.reloadRows(at: [selectedIndexPath], with: .none)
//            } else {
//                let newIndexPath = IndexPath(row: notes.count, section: 0)
//                notes.append(note)
//                tableView.insertRows(at: [newIndexPath], with: .automatic)
//            }
//        }
   }
    
    override func prepare(for segue: UIStoryboardSegue, sender:
        Any?) {
        if segue.identifier == "EditNote" {
            let indexPath = tableView.indexPathForSelectedRow!
            let note = notes[indexPath.row]
            let navController = segue.destination as!
            UINavigationController
            let addViewController = navController.topViewController as! AddViewController
            addViewController.note = note
        }
    }
    
    // MARK: - AddViewControllerDelegate
    
    func noteCreated(note: NoteList) {
        notes.append(note)
        tableView.reloadData()
    }
    
    // MARK: SendEmailDelegate 

    func sendEmail(email: String) {
        
        guard MFMailComposeViewController.canSendMail() else { return }
        let alert = UIAlertController.init(title: "Send E-mail", message: "Your registration was successfully done!", preferredStyle: .alert)
        let action = UIAlertAction.init(title: "OK", style: .default) { (UIAlertAction) in
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            mailComposer.setToRecipients([email])
            mailComposer.setSubject("Registration")
            mailComposer.setMessageBody("Your registration was successfully done!", isHTML: false)
            self.present(mailComposer, animated: true, completion: nil)
        }
        alert.addAction(action)
        self.present(alert, animated: true,completion: nil)
    }
    // MARK: - MFMailComposeViewControllerDelegate -
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled: print("cancelled")
        case .failed: print("failed")
        case .saved: print("saved")
        case .sent: print("sent")
        default:
            break
        }
        controller.dismiss(animated: true, completion: nil)
    }
}
