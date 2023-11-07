//
//  NewTaskView.swift
//  Tasker
//
//  Created by Snow Lukin on 07.11.2023.
//

import SwiftUI
import SwiftData

struct NewTaskView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var title = ""
    @State private var date = Date()
    @State private var taskColor = Color.taskColors[0]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            closeButton
            titleSection
            
            HStack(spacing: 12) {
                dateSection
                colorSection
            }
            .padding(.top, 5)
            
            Spacer(minLength: 0)
            
            creationButton
        }
        .padding(15)
    }
}

#Preview {
    NewTaskView()
        .move(.bottom)
}

extension NewTaskView {
    
    @ViewBuilder
    private var closeButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark.circle.fill")
                .font(.title)
                .tint(.red)
        }
        .moveHorizontal(.leading)
    }
    
    @ViewBuilder
    private var creationButton: some View {
        Button {
            let task = Task(title, message: "", creationDate: date, tint: taskColor)
            do {
                modelContext.insert(task)
                try modelContext.save()
                dismiss()
            } catch {
                debugPrint(error.localizedDescription)
            }
        } label: {
            Text("Create Task")
                .font(.title3)
                .fontWeight(.semibold)
                .textScale(.secondary)
                .foregroundStyle(.black)
                .moveHorizontal(.center)
                .padding(.vertical, 12)
                .background(Color(taskColor), in: .rect(cornerRadius: 10))
        }
        .disabled(title.isEmpty)
        .opacity(title.isEmpty ? 0.5 : 1)
    }
    
    @ViewBuilder
    private var colorSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Task Color")
                .font(.caption)
                .foregroundStyle(.gray)
            
            HStack(spacing: 0) {
                ForEach(Color.taskColors, id: \.self) { color in
                    Circle()
                        .fill(Color(color))
                        .frame(width: 20)
                        .background {
                            Circle()
                                .stroke(lineWidth: 2)
                                .opacity(taskColor == color ? 1 : 0)
                        }
                        .moveHorizontal(.center)
                        .contentShape(.rect)
                        .onTapGesture {
                            withAnimation(.snappy) {
                                taskColor = color
                            }
                        }
                }
            }
        }
        .padding(.top, 5)
    }
    
    @ViewBuilder
    private var dateSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Task Date")
                .font(.caption)
                .foregroundStyle(.gray)
            
            DatePicker("", selection: $date)
                .datePickerStyle(.compact)
                .scaleEffect(0.9, anchor: .leading)
        }
        .padding(.trailing, -15) // more space for tapping
    }
    
    @ViewBuilder
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Task Title")
                .font(.caption)
                .foregroundStyle(.gray)
            
            TextField("Earn one million", text: $title)
                .padding(.vertical, 12)
                .padding(.horizontal, 15)
                .background(.white.shadow(.drop(color: .black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
        }
        .padding(.top, 5)
    }
}
