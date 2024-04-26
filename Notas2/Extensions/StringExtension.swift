//
//  StringExtension.swift
//  Notas2
//
//  Created by DISMOV on 24/04/24.
//

import Foundation

public extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
}
