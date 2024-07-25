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
            ForEach(1..<4) { index in
                Text("\(index)")
                    .frame(width: 150, height: 150)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .tag(index)
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
