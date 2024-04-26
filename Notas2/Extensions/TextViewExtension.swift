//
//  TextViewExtension.swift
//  Notas2
//
//  Created by MAGH on 25/04/24.
//

import Foundation
import UIKit

public extension UITextView {
    func setPlaceholder(_ text: String){
        self.text = text
        self.textColor = UIColor.lightGray
        self.selectedTextRange = self.textRange(from: self.beginningOfDocument, to: self.beginningOfDocument)
    }
}
