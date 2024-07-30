//
//  ProfileView.swift
//  Sennight
//
//  Created by 한유진 on 7/30/24.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var smokingHabitViewModel: SmokingHabitViewModel
    
    // To hold the date picker value
    @State private var firstCigaretteTime: Date = Date()
    
    var body: some View {
        Form {
            Section(header: Text("Smoking Habits")) {
                HStack {
                    Text("Daily Cigarettes")
                    Spacer()
                    TextField("Enter daily cigarettes", value: $smokingHabitViewModel.dailyCigarettes, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                HStack {
                    Text("Cigarette Price")
                    Spacer()
                    TextField("Enter cigarette price", value: $smokingHabitViewModel.cigarettePrice, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            
            Section(header: Text("First Cigarette Time")) {
                DatePicker("First Cigarette Time", selection: $firstCigaretteTime, displayedComponents: .hourAndMinute)
                    .onChange(of: firstCigaretteTime) { oldValue, newValue in
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "HH:mm:ss.SSS'Z'"
                        smokingHabitViewModel.firstCigarette = dateFormatter.string(from: newValue)
                    }
            }
            
            Section(header: Text("Smoking History")) {
                HStack {
                    Text("Years Smoking")
                    Spacer()
                    TextField("Enter years smoking", value: $smokingHabitViewModel.smokingYears, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
        }
        .navigationTitle("Profile")
    }
}

#Preview {
    ProfileView()
        .environmentObject(SmokingHabitViewModel())
}
