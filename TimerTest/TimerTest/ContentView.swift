//
//  ContentView.swift
//  TimerTest
//
//  Created by wizard on 7/25/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var myTimer = MyTimer()
    let range1 = Date()...Date().addingTimeInterval(30)
    let range2 = Date()...Date().addingTimeInterval(60)
    var body: some View {
        VStack {
            Text("\(self.myTimer.value)")
                .font(.largeTitle)
            
            ProgressView(timerInterval: range1).padding()
            
            ProgressView(timerInterval: range2, countsDown: false).padding()
            
            ProgressView(timerInterval: range2, countsDown: false) {
                Text(String(format:"%.1f%%", (Double(self.myTimer.value)/60.0*100)))
            }.padding()
        }
    }
}

#Preview {
    ContentView()
}
