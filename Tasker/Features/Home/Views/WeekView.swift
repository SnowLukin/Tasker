//
//  WeekView.swift
//  Tasker
//
//  Created by Snow Lukin on 07.11.2023.
//

import SwiftUI

struct WeekView: View {
    
    let days: [Date.WeekDay]
    @ObservedObject var viewModel: HomeViewModel
    
    @Namespace private var animation
    private let animationID = UUID().uuidString
    
    var body: some View {
        HStack(spacing: 5) {
            ForEach(days) { day in
                VStack(spacing: 8) {
                    Text(day.date.format("E"))
                        .font(.callout)
                        .fontWeight(.medium)
                        .textScale(.secondary)
                        .foregroundStyle(.gray)
                    
                    Text(day.date.format("dd"))
                        .font(.callout)
                        .fontWeight(.bold)
                        .textScale(.secondary)
                        .foregroundStyle(
                            isSameDay(day.date, viewModel.currentDate)
                            ? .white
                            : .gray
                        )
                        .frame(width: 35, height: 35)
                        .background {
                            if isSameDay(day.date, viewModel.currentDate) {
                                Circle()
                                    .fill(.blue)
                                    .matchedGeometryEffect(
                                        id: "animationID",
                                        in: animation
                                    )
                            }
                            
                            if day.date.isToday {
                                Circle()
                                    .fill(.green)
                                    .frame(width: 5, height: 5)
                                    .move(.bottom)
                                    .offset(y: 11)
                            }
                        }
                        .background(.white.shadow(.drop(radius: 1)), in: .circle)
                }
                .moveHorizontal(.center)
                .contentShape(.rect)
                .onTapGesture {
                    withAnimation {
                        viewModel.currentDate = day.date
                    }
                }
            }
        }
    }
}
