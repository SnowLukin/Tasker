//
//  TasksView.swift
//  Tasker
//
//  Created by Snow Lukin on 07.11.2023.
//

import SwiftUI
import SwiftData

struct TasksView: View {
    
    @Binding var currentDate: Date
    @Query private var tasks: [Task]
    
    init(currentDate: Binding<Date>) {
        self._currentDate = currentDate
        
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: currentDate.wrappedValue)
        let endOfDate = calendar.date(byAdding: .day, value: 1, to: startOfDate)!
        
        let predicate = #Predicate<Task> {
            $0.creationDate >= startOfDate && $0.creationDate < endOfDate
        }
        let sortDescription = [
            SortDescriptor(\Task.creationDate, order: .reverse)
        ]
        self._tasks = Query(filter: predicate, sort: sortDescription, animation: .snappy)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            ForEach(tasks) { task in
                TaskRowView(task: task)
                    .background(alignment: .leading) {
                        if tasks.last?.id != task.id {
                            Rectangle()
                                .frame(width: 2)
                                .offset(x: 8)
                                .padding(.bottom, -15)
                        }
                    }
            }
        }
        .padding([.top, .leading], 15)
        .padding(.vertical, 15)
        .overlay {
            if tasks.isEmpty {
                Text("No task found")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .frame(width: 150)
            }
        }
    }
}

#Preview {
    HomeView()
}
