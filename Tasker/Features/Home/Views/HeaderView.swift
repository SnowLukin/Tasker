//
//  HeaderView.swift
//  Tasker
//
//  Created by Snow Lukin on 07.11.2023.
//

import SwiftUI

struct HeaderView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 5) {
                Text(viewModel.headerMonth)
                    .foregroundStyle(.blue)
                Text(viewModel.headerYear)
                    .foregroundStyle(.gray)
            }
            .font(.title.bold())
            
            Text(viewModel.completeDate)
                .font(.callout)
                .fontWeight(.semibold)
                .textScale(.secondary)
                .foregroundStyle(.gray)
            
            WeekSliderView(viewModel: viewModel)
        }
        .move(.leading)
        .padding(15)
        .background(.white)
        .onChange(of: viewModel.currentWeekIndex) { oldValue, newValue in
            // updaing when it reached first/last week
            if newValue == 0 || newValue == viewModel.weeks.count - 1 {
                viewModel.shouldCreateWeek = true
            }
        }
    }
}
