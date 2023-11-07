//
//  TaskRowView.swift
//  Tasker
//
//  Created by Snow Lukin on 07.11.2023.
//

import SwiftUI
import SwiftData

struct TaskRowView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Bindable var task: Task
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            indicatorCircle()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(task.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                
                Label(task.creationDate.format("hh:mm a"), systemImage: "clock")
                    .font(.caption)
                    .foregroundStyle(.black)
            }
            .padding(15)
            .strikethrough(task.isCompleted, pattern: .solid, color: .black)
            .moveHorizontal(.leading)
            .background(task.tintColor, in: .rect(topLeadingRadius: 15, bottomLeadingRadius: 15))
            .contentShape(.contextMenuPreview, .rect(cornerRadius: 15))
            .contextMenu {
                Button("Delete Task", role: .destructive) {
                    withAnimation(.spring) {
                        modelContext.delete(task)
                        try? modelContext.save()
                    }
                }
            }
            .offset(y: -8)
        }
    }
}

#Preview {
    HomeView()
}

extension TaskRowView {
    
    var indicatorColor: Color {
        task.isCompleted ? .green : task.creationDate.isSameHour ? .blue
        : task.creationDate.isPast ? .red : .black
    }
    
    @ViewBuilder
    private func indicatorCircle() -> some View {
        Circle()
            .fill(indicatorColor)
            .frame(width: 10, height: 10)
            .padding(4)
            .background(
                .white.shadow(
                    .drop(
                        color: .black.opacity(0.1),
                        radius: 3
                    )
                ), in: .circle
            )
            .overlay {
                Circle()
                    .foregroundStyle(.clear)
                    .contentShape(.circle)
                    .frame(width: 50, height: 50)
                    .onTapGesture {
                        print(task.isCompleted)
                        withAnimation(.snappy) {
                            task.isCompleted.toggle()
                        }
                    }
            }
    }
}
