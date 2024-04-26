//
//  AddNoteViewController.swift
//  Notas2
//
//  Created by MAGH on 24/04/24.
//

import UIKit

class AddNoteViewController: UIViewController, UITextViewDelegate, UIAlertViewDelegate {
    
    var note: Note?
    var noteIndex: Int?
    
    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var noteContent: UITextView!
    @IBOutlet weak var noteBackgroundPicker: UIColorWell!
    @IBOutlet weak var noteImportantSwitch: UISwitch!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //UI configuration
        noteContent.delegate = self
        
        noteContent.setPlaceholder(Constants().NOTE_CONTENT_PLACEHOLDER)
        noteBackgroundPicker.selectedColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        noteImportantSwitch.isOn = false
        
        //Fill note data
        if (note != nil){
            noteTitle.text = note!.title
            noteContent.text = note!.content
            noteContent.textColor = UIColor.black
            noteBackgroundPicker.selectedColor = UIColor(
                red: note!.background[0],
                green: note!.background[1],
                blue: note!.background[2],
                alpha: note!.background[3]
            )
            noteImportantSwitch.isOn = note!.important
        }else{
            deleteButton.isHidden = true
            saveButton.isEnabled = false
        }
    }
    
    // MARK: - Placeholder in noteContent
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText: String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        if updatedText.isEmpty {
            textView.setPlaceholder(Constants().NOTE_CONTENT_PLACEHOLDER)
            textViewDidChange(textView)
            return false
        } else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.textColor = UIColor.black
            textView.text = text
            textViewDidChange(textView)
            return false
        } else {
            return true
        }
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
    
    // MARK: - Validation
    
    func validateFields() -> Bool {
        return !(noteTitle.text!.trim().isEmpty) &&
            !(noteContent.textColor == UIColor.lightGray)
    }
    
    @IBAction func textFieldChanged(_ textField: UITextField) {
        saveButton.isEnabled = validateFields()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        saveButton.isEnabled = validateFields()
    }
    
    // MARK: - Navigation
    
    @IBAction func deleteButtonPressed(_ sender: UIBarButtonItem) {
        let alertMessage = UIAlertController(title: "Are you sure?", message: "Deleting this note cannot be undone.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Yes, delete it!", style: .destructive){_ in
            self.performSegue(withIdentifier: "deleteUnwindSegue", sender: self)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){_ in
        }
        alertMessage.addAction(okAction)
        alertMessage.addAction(cancelAction)
        self.present(alertMessage, animated: true, completion: nil)
    }
    
    /*override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (deleteButton == (sender as! UIBarButtonItem)){
            return true
        }else{
            return validateFields()
        }
    }*/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        note = Note(
            title: noteTitle.text ?? "",
            content: noteContent.text,
            date: Date(),
            background: (noteBackgroundPicker.selectedColor?.cgColor.components!)!,
            important: noteImportantSwitch.isOn
        )
        //let destination = segue.destination as! NotesViewController
        //destination.note = note
    }

    @IBAction func cancelClicked(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
}
