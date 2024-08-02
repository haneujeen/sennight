//
//  NewSmokingLogSheet.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//

import SwiftUI

struct NewSmokingLogSheet: View {
    @Binding var selectedDate: Date
    @Binding var isNewSmokingLogSheetPresented: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Craving level")
                    .font(.title)
                Text("Trigger")
                    .font(.title)
                DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .padding()
            }
            .navigationBarItems(trailing: Button("Save") {
                isNewSmokingLogSheetPresented = false
            })
        }
    }
}

#Preview {
    NewSmokingLogSheet(selectedDate: .constant(Date()), isNewSmokingLogSheetPresented: .constant(true))
}
