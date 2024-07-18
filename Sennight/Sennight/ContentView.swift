//
//  ContentView.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//

import SwiftUI

struct ContentView: View {
    var loginViewModel = LoginViewModel()
    
    var body: some View {
        EntryView()
            .environmentObject(loginViewModel)
    }
}

#Preview {
    ContentView()
}
