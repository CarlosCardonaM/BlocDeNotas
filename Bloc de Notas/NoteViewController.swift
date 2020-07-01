//
//  NoteViewController.swift
//  Bloc de Notas
//
//  Created by Carlos Cardona on 03/06/20.
//  Copyright © 2020 D O G. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController, UITextViewDelegate {

    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var bodyTextView: UITextView!
    
    @IBOutlet weak var starButton: UIButton!
    
    var note:Note?
    var notesModel:NotesModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // User is viewing an existing note, so populate the fields
        if note != nil {
            titleTextField.text = note?.title
            bodyTextView.text = note?.body
            
            // Set the status of the star button
            setStarButton()
        }
        else {
            
            // Note property is nil, so create a new note
            // Create the note
            let n = Note(docId: UUID().uuidString, title: titleTextField.text ?? "Set Title", body: bodyTextView.text ?? "Set Note Body", isStarred: false, createdAt: Date(), lastUpdatedAt: Date())
            
            self.note = n
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        // Crear the field
        note = nil

        titleTextField.text = ""
        bodyTextView.text = ""
    }
    
    
    func setStarButton() {
        let imageName = note!.isStarred ? "star.fill" : "star"
        
        starButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        
        if self.note != nil {
            notesModel?.deleteNote(self.note!)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveTapped(_ sender: Any) {
        
        // This is an update to an existing note
        self.note?.title = titleTextField.text ?? ""
        self.note?.body = bodyTextView.text ?? ""
        self.note?.lastUpdatedAt = Date()
        
        // Send it to the notes model
        self.notesModel?.saveNote(self.note!)
        
        dismiss(animated: true, completion: nil)

    }
    
    @IBAction func starTapped(_ sender: Any) {
        
        // change the property in the note
        note?.isStarred.toggle()
        
        // Update the database
        notesModel?.updateFaveStatus(note!.docId, note!.isStarred)
        
        // Update the button
        setStarButton()
    }
    
}


