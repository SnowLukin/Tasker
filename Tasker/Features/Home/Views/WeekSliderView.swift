//
//  WeekSliderView.swift
//  Tasker
//
//  Created by Snow Lukin on 07.11.2023.
//

import SwiftUI

struct WeekSliderView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        TabView(selection: $viewModel.currentWeekIndex) {
            ForEach(viewModel.weeks.indices, id: \.self) { index in
                WeekView(days: viewModel.weeks[index], viewModel: viewModel)
                    .background {
                        GeometryReader {
                            let minX = $0.frame(in: .global).minX
                            
                            Color.clear
                                .preference(key: OffsetKey.self, value: minX)
                                .onPreferenceChange(OffsetKey.self) { value in
                                    // When the offset reached 15 and createWeek is on we generating new week
                                    if value.rounded() == 15, viewModel.shouldCreateWeek {
                                        viewModel.paginateWeek()
                                        viewModel.shouldCreateWeek = false
                                    }
                                }
                        }
                    }
                    .tag(index)
                    .padding(.horizontal, 15)
            }
        }
        .padding(.horizontal, -15)
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 90)
    }
}
