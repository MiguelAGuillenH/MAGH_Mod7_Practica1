//
//  NotesViewController.swift
//  Notas2
//
//  Created by MAGH on 23/04/24.
//

import UIKit

class NotesViewController: UITableViewController {
    
    @IBOutlet var notesList: UITableView!
    @IBOutlet var emptyNotesView: UIView!
    
    var notesManager = NotesManager()
    var selectedNote: Note?
    var selectedNoteIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        notesManager.loadNotes()
        updateUI()
    }
    
    func updateUI(){
        if notesManager.countNotes() == 0 {
            emptyNotesView.isHidden = false
            notesList.backgroundView = emptyNotesView
        }else{
            emptyNotesView.isHidden = true
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesManager.countNotes()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NoteCell
        let note = notesManager.getNote(at: indexPath.row)
        cell?.noteTitle.text = note.title
        cell?.noteDate.text = note.date.iso8601String
        cell?.backgroundColor = UIColor(
            red: note.background[0],
            green: note.background[1],
            blue: note.background[2],
            alpha: note.background[3]
        )
        if (note.important){
            cell?.noteTitle.textColor = UIColor.red
        }
        return cell!
    }
    
    // MARK: - Navigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedNote = notesManager.getNote(at: indexPath.row)
        selectedNoteIndex = indexPath.row
        self.performSegue(withIdentifier: "noteEditSegue", sender: Self.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navController = segue.destination as! UINavigationController
        let destination = navController.viewControllers.first as! AddNoteViewController
        destination.note = selectedNote
        destination.noteIndex = selectedNoteIndex
        selectedNote = nil
        selectedNoteIndex = nil
    }
    
    //Unwind segue
    @IBAction func saveButtonUnwindToNotesViewController(_ segue: UIStoryboardSegue) {
        let source = segue.source as! AddNoteViewController
        let newNote = source.note!
        let newNoteIndex: Int? = source.noteIndex
        if (newNoteIndex == nil){
            notesManager.createNote(note: newNote)
        }else{
            notesManager.updateNote(at: newNoteIndex!, note: newNote)
        }
        notesManager.saveNotes()
        
        //Reload table view
        notesList.reloadData()
        updateUI()
    }
    
    @IBAction func deleteButtonUnwindToNotesViewController(_ segue: UIStoryboardSegue) {
        let source = segue.source as! AddNoteViewController
        let newNoteIndex: Int? = source.noteIndex
        if (newNoteIndex != nil){
            notesManager.deleteNote(at: newNoteIndex!)
        }
        notesManager.saveNotes()
        
        //Reload table view
        notesList.reloadData()
        updateUI()
    }
    
}
