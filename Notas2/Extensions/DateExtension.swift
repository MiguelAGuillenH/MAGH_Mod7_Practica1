//
//  DateExtension.swift
//  Notas2
//
//  Created by MAGH on 23/04/24.
//

import Foundation

public extension Date{
    
    var iso8601String: String {
        Formatter.iso8601Local.string(from: self)
    }
    
}
