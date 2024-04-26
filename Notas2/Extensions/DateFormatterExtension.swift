//
//  DateFormatterExtension.swift
//  Notas2
//
//  Created by MAGH on 23/04/24.
//

import Foundation

public extension Formatter {
    static let iso8601MX: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "es_MX")
        formatter.timeZone = TimeZone(identifier: "America/Mexico_City")
        //formatter.dateFormat = "dd/MM/yyyy'T'HH:mm:ss.SSSZZZZZ"
        formatter.dateFormat = "dd/MM/yyyy' 'HH:mm:ss"
        return formatter
    }()
    static let iso8601Local: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = .autoupdatingCurrent
        formatter.timeZone = .autoupdatingCurrent
        formatter.dateFormat = "dd/MM/yyyy' 'HH:mm:ss"
        return formatter
    }()
}
