//
//  ViewController.swift
//  Bloc de Notas
//
//  Created by Carlos Cardona on 03/06/20.
//  Copyright © 2020 D O G. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var isStarFiltered = false
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var starButton: UIBarButtonItem!
    
    private var notesModel = NotesModel()
    private var notes:[Note] = [Note]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Set delegate and datasource to the tableview
        tableView.delegate = self
        tableView.dataSource = self
        
        // Set self as the delegate for the notes model
        notesModel.delegate = self
        
        // set the status of the star filter button
        setStartFilterButton()
        
        //Retrieve all notes acording to the filter status
        
        isStarFiltered ? notesModel.getNotes(true) : notesModel.getNotes()
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let noteViewController = segue.destination as! NoteViewController
        
        // If the user has selected a row, transition to note vc
        if tableView.indexPathForSelectedRow != nil {
            
            // Set the note and notes model properties of the note vc
            noteViewController.note = notes[tableView.indexPathForSelectedRow!.row]
            
            // Deselect the selected row so that it doesn't interfere with new note creation
            tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: false)
        }
        // Wether it's a new note or a selected note, we still want to pass trhough the notes model
        noteViewController.notesModel = self.notesModel
        
        

    }
    
    func setStartFilterButton() {
        let imageName = isStarFiltered ? "star.fill" : "star"
        starButton.image = UIImage(systemName: imageName)
    }
    
    
    @IBAction func starFilterTapped(_ sender: Any) {
        
        // toggle the starred filter status
        isStarFiltered.toggle()
        
        // Run the query
        isStarFiltered ? notesModel.getNotes(true) : notesModel.getNotes()
        
        // Update the star button
        setStartFilterButton()
    }
    

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return notes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        
        // Customize cell
        let titleLabel = cell.viewWithTag(1) as? UILabel
        titleLabel?.text = notes[indexPath.row].title
        
        let bodyLabel = cell.viewWithTag(2) as? UILabel
        bodyLabel?.text = notes[indexPath.row].body
        
        // Return cell
        return cell
    }
    
    
}

extension ViewController: NotesModelProtocol {

    func notesRetrieved(notes: [Note]) {
        
        // Set notes property and refresh the table view
        self.notes = notes
        
        tableView.reloadData()
    }
}
