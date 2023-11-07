//
//  Date+Extension.swift
//  Tasker
//
//  Created by Snow Lukin on 07.11.2023.
//

import Foundation

extension Date {
    
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
    
    var isSameHour: Bool {
        Calendar.current.compare(self, to: .init(), toGranularity: .hour) == .orderedSame
    }
    
    var isPast: Bool {
        Calendar.current.compare(self, to: .init(), toGranularity: .hour) == .orderedAscending
    }
    
    static func updateHour(_ value: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .hour, value: value, to: .init()) ?? .init()
    }
    
    func format(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    // Week based on given date
    func fetchWeek(_ date: Date = .init()) -> [WeekDay] {
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: date)
        
        var week: [WeekDay] = []
        let weekForDate = calendar.dateInterval(of: .weekOfMonth, for: startOfDate)
        guard let startOfWeek = weekForDate?.start else { return [] }
        
        (0..<7).forEach { index in
            if let weekDay = calendar.date(byAdding: .day, value: index, to: startOfWeek) {
                let day = WeekDay(date: weekDay)
                week.append(day)
            }
        }
        return week
    }
    
    // Next week based on last current week's date
    func createNextWeek() -> [WeekDay] {
        let calendar = Calendar.current
        let startOfLastDate = calendar.startOfDay(for: self)
        guard let nextDate = calendar.date(byAdding: .day, value: 1, to: startOfLastDate) else {
            return []
        }
        return fetchWeek(nextDate)
    }
    
    // Previous week based on last current week's date
    func createPreviousWeek() -> [WeekDay] {
        let calendar = Calendar.current
        let startOfFirstDate = calendar.startOfDay(for: self)
        guard let previousDate = calendar.date(byAdding: .day, value: -1, to: startOfFirstDate) else {
            return []
        }
        return fetchWeek(previousDate)
    }
}

extension Date {
    struct WeekDay: Identifiable {
        var id: UUID = .init()
        var date: Date
    }
}
