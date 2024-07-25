//
//  ContentView.swift
//  TimerTest
//
//  Created by wizard on 7/25/24.
//

import SwiftUI

struct ContentView: View {
    
   
    @ObservedObject var myTimer = MyTimer()
    
    var body: some View {
        VStack {
            Text("\(self.myTimer.value)")
                .font(.largeTitle)
            
          
            ProgressView(value: Float(self.myTimer.value), total: 100.0).padding()
            
            ProgressView(value: Float(self.myTimer.value), total: 10.0).padding()
        }
        
        
    }
}

#Preview {
    ContentView()
}
