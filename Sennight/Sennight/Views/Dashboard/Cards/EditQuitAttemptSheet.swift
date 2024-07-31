//
//  EditQuitAttemptSheet.swift
//  Sennight
//
//  Created by 한유진 on 7/28/24.
//

import SwiftUI

struct EditQuitAttemptSheet: View {
    @Binding var selectedDate: Date
    @Binding var isEditSheetPresented: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Update start date")
                    .font(.title)
                DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .padding()
            }
            .navigationBarItems(trailing: Button("Save") {
                isEditSheetPresented = false // Dismiss the modal
            })
        }
    }
}

#Preview {
    EditQuitAttemptSheet(selectedDate: .constant(Date()), isEditSheetPresented: .constant(true))
}
