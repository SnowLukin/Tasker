//
//  Task.swift
//  Tasker
//
//  Created by Snow Lukin on 06.11.2023.
//

import SwiftUI
import SwiftData

@Model
final class Task: Identifiable {
    var id: UUID
    var title: String
    var message: String
    var isCompleted: Bool = false
    var tint: String
    var creationDate: Date
    
    var tintColor: Color {
        Color(tint)
    }
    
    init(
        id: UUID = .init(),
        _ title: String,
        message: String,
        creationDate: Date = .init(),
        isCompleted: Bool = false,
        tint: String
    ) {
        self.id = UUID()
        self.title = title
        self.message = message
        self.isCompleted = isCompleted
        self.tint = tint
        self.creationDate = creationDate
    }
}

//extension Task {
//    static var MOCK = [
//        Task("Something", message: "1", isCompleted: false, tint: .red),
//        Task("Something1", message: "2", isCompleted: true, tint: .cyan),
//        Task("Something2", message: "3", isCompleted: false, tint: .orange),
//        Task("Something3", message: "4", isCompleted: true, tint: .green),
//        Task("Something4", message: "5", isCompleted: false, tint: .white),
//        Task("Something5", message: "6", isCompleted: true, tint: .yellow),
//    ]
//}
