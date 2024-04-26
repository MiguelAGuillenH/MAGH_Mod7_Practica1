//
//  Note.swift
//  Notas2
//
//  Created by MAGH on 23/04/24.
//

import Foundation

struct Note: Codable {
    var title: String
    var content: String
    var date: Date
    var background: [CGFloat]
    var important: Bool
}
