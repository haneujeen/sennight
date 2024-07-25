//
//  PagingView.swift
//  TimerTest
//
//  Created by 한유진 on 7/25/24.
//

import SwiftUI

struct PagingView: View {
    @State private var selection = 1
    
    var body: some View {
        Text("\(selection)")
        TabView(selection: $selection) {
            ForEach(intervals.indices, id: \.self) { index in
                ProgressViewView(interval: intervals[index])
                    .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        //.frame(height: 150)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation {
                    selection = 2
                }
                print("Selection set to: \(selection)")
            }
        }
    }
}

#Preview {
    PagingView()
}
