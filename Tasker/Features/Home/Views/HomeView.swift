//
//  HomeView.swift
//  Tasker
//
//  Created by Snow Lukin on 07.11.2023.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            Color(.background)
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 0) {
                HeaderView(viewModel: viewModel)
                ScrollView(.vertical) {
                    VStack {
                        TasksView(currentDate: $viewModel.currentDate)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }.scrollIndicators(.hidden)
            }
            .move(.top)
            .overlay(alignment: .bottomTrailing) {
                Button {
                    viewModel.createNewTask.toggle()
                } label: {
                    Image(systemName: "plus")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: 55, height: 55)
                        .background(.blue.shadow(.drop(color: .black.opacity(0.25), radius: 5, x: 10, y: 10)), in: .circle)
                }.padding(15)
            }
            .onAppear {
                viewModel.onAppear()
            }
            .sheet(isPresented: $viewModel.createNewTask) {
                NewTaskView()
                    .presentationDetents([.height(300)])
                    .interactiveDismissDisabled()
                    .presentationCornerRadius(30)
                    .presentationBackground(Color(.background))
            }
        }
    }
}

#Preview {
    HomeView()
}

extension HomeView {
    
}
