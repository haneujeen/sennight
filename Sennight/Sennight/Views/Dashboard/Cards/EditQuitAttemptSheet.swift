//
//  EditQuitAttemptSheet.swift
//  Sennight
//
//  Created by 한유진 on 7/28/24.
//

import SwiftUI

struct EditQuitAttemptSheet: View {
    @EnvironmentObject var quitAttemptViewModel: QuitAttemptViewModel
    
    @Binding var selectedDate: Date
    @Binding var isEditSheetPresented: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Update the date you started to quit.")
                    .font(.title2)
                DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(.wheel)
                    .frame(height: 130)
                    .clipped()
                    .labelsHidden()
                    .padding(.horizontal)
                    .padding(.vertical, 50)
            }
            .navigationBarItems(trailing: Button(action: {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let selectedDateString = dateFormatter.string(from: selectedDate)
                quitAttemptViewModel.startDate = selectedDateString
                quitAttemptViewModel.updateQuitAttempt()
                quitAttemptViewModel.getActiveQuitAttempt()
                isEditSheetPresented = false
            }) {
                Text("Save")
                    .foregroundColor(.blue)
            })
        }
    }
}

#Preview {
    EditQuitAttemptSheet(selectedDate: .constant(Date()), isEditSheetPresented: .constant(true))
}
