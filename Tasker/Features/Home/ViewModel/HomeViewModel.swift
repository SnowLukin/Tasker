//
//  HomeViewModel.swift
//  Tasker
//
//  Created by Snow Lukin on 07.11.2023.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published var currentDate = Date()
    @Published var weeks: [[Date.WeekDay]] = []
    @Published var currentWeekIndex = 1
    @Published var shouldCreateWeek = false
    
    @Published var createNewTask = false
    
    var headerMonth: String {
        currentDate.format("MMMM")
    }
    
    var headerYear: String {
        currentDate.format("YYYY")
    }
    
    var completeDate: String {
        currentDate.formatted(date: .complete, time: .omitted)
    }
    
    func onAppear() {
        let currentWeek = Date().fetchWeek()
        
        if let firstDate = currentWeek.first?.date {
            weeks.append(firstDate.createPreviousWeek())
        }
        
        weeks.append(currentWeek)
        
        if let lastDate = currentWeek.last?.date {
            weeks.append(lastDate.createNextWeek())
        }
    }
    
    func paginateWeek() {
        if weeks.indices.contains(currentWeekIndex) {
            if let firstDate = weeks[currentWeekIndex].first?.date, currentWeekIndex == 0 {
                weeks.insert(firstDate.createPreviousWeek(), at: 0)
                weeks.removeLast()
                currentWeekIndex = 1
            }
            
            if let lastDate = weeks[currentWeekIndex].last?.date, currentWeekIndex == weeks.count - 1 {
                weeks.append(lastDate.createNextWeek())
                weeks.removeFirst()
                currentWeekIndex = weeks.count - 2
            }
        }
    }
}
