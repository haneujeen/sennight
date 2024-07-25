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
        TabView(selection: $selection) {
            ForEach(intervals, id: \.self) { interval in
                ProgressViewView(interval: interval)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .frame(height: 150)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation {
                    selection = 2
                }
            }
        }
    }
}

#Preview {
    PagingView()
}
