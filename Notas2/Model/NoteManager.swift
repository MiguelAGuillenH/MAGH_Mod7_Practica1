//
//  NoteManager.swift
//  Notas2
//
//  Created by MAGH on 23/04/24.
//

import Foundation

class NotesManager {
    
    private var notes : [Note] = []
    
    func createNote(note: Note) {
        notes.append(note)
    }
    
    func updateNote(at index: Int, note: Note) {
        if (index < notes.count) {
            notes[index] = note
        }
    }
    
    func deleteNote(at index: Int) {
        notes.remove(at: index)
    }
    
    func getNotes() -> [Note] {
        return notes
    }
    
    func getNote(at index: Int) -> Note {
        return notes[index]
    }
    
    func countNotes() -> Int {
        return notes.count
    }
    
    func saveNotes() {
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let notesURL = documentDirectory.appending(component: "notes.json")

        do {
            let jsonData = try JSONEncoder().encode(notes)
            fileManager.createFile(atPath: notesURL.path(), contents: jsonData)
        }catch let error {
            print("Error al guardar notes.json.", error)
        }
    }
    
    func loadNotes() {
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let notesURL = documentDirectory.appending(component: "notes.json")
        
        if (fileManager.fileExists(atPath: notesURL.path())) {
            do{
                let jsonData = fileManager.contents(atPath: notesURL.path())
                notes = try JSONDecoder().decode([Note].self, from: jsonData!)
            }catch let error{
                print("Error al leer notes.json.",error)
            }
        }else{
            print("File notes.json does not exist.")
        }
    }
    
}

