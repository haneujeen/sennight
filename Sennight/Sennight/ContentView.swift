//
//  ContentView.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showSplashScreen = true
    
    var body: some View {
        if showSplashScreen {
            SplashScreenView()
                .transition(.opacity)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.3) {
                        withAnimation {
                            showSplashScreen = false
                        }
                    }
                }
        } else {
            EntryView()
                .transition(.opacity)
        }
        
    }
}

#Preview {
    ContentView()
}
