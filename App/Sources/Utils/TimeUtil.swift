//
//  DateUtil.swift
//  App
//
//  Created by ibnu on 26/04/25.
//

import Foundation

func getCurrentGreeting() -> String {
    let hour = Calendar.current.component(.hour, from: Date())

    switch hour {
    case 6..<12 : 
        return "Morning"
    case 12..<17 : 
        return "Afternoon"
    case 17..<22 : 
        return "Evening"
    default: 
        return "Night"
    }
}

func stringToDate(dateString: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    return dateFormatter.date(from:dateString)
}

func dateToString(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter.string(from: date)
}


