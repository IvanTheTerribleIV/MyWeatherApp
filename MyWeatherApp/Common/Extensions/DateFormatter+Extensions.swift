//
//  DateFormatter+Extensions.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 20.07.2025.
//

import Foundation

extension DateFormatter {
    static let weekDayDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter
    }()
    
    static let shortDateForematter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyy"
        return formatter
    }()
    
    static let hoursDateForematter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
}
