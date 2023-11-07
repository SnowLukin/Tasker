//
//  View+Extensions.swift
//  Tasker
//
//  Created by Snow Lukin on 07.11.2023.
//

import SwiftUI

extension View {
    
    @ViewBuilder
    func move(_ alignment: Alignment) -> some View {
        switch alignment {
        case .trailing, .trailingLastTextBaseline, .trailingFirstTextBaseline,
                .leading, .leadingLastTextBaseline, .leadingFirstTextBaseline:
            moveHorizontal(alignment)
        default:
            moveVertical(alignment)
        }
    }
    
    @ViewBuilder
    func moveHorizontal(_ alignment: Alignment) -> some View {
        self.frame(maxWidth: .infinity, alignment: alignment)
    }
    
    @ViewBuilder
    func moveVertical(_ alignment: Alignment) -> some View {
        self.frame(maxHeight: .infinity, alignment: alignment)
    }
    
    func isSameDay(_ date1: Date, _ date2: Date) -> Bool {
        Calendar.current.isDate(date1, inSameDayAs: date2)
    }
}
