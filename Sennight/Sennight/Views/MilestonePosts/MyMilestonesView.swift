//
//  MyMilestonesView.swift
//  Sennight
//
//  Created by 한유진 on 7/2/24.
//

import SwiftUI

struct MyMilestonesView: View {
    @State private var selectedOption = 0
    
    var body: some View {
        VStack {
            Picker("Filter", selection: $selectedOption) {
                Text("All").tag(0)
                Text("My Quit History").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            if selectedOption == 0 {
            } else {
            }
        }
    }
}

#Preview {
    MyMilestonesView()
}
