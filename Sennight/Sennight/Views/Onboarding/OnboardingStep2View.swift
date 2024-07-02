//
//  OnboardingStep2View.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//

import SwiftUI

struct OnboardingStep2View: View {
    @Binding var currentStep: Int
    @Binding var isOnboardingComplete: Bool
    @State private var quitDate = Date()
    @State private var cigarettePrice = ""
    @State private var cigarettesPerDay = ""
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    isOnboardingComplete = true
                }) {
                    Text("Dismiss")
                        .foregroundColor(.red)
                }
                .padding()
            }
            
            Spacer()
            Text("Step 2: Create Quit Log")
                .font(.largeTitle)
                .padding(.bottom, 40)
            DatePicker("Quit Date", selection: $quitDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
            
            TextField("Price of a cigarette or a pack of cigarettes", text: $cigarettePrice)
                .keyboardType(.decimalPad)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.bottom, 20)
            
            TextField("Number of Cigarettes per Day", text: $cigarettesPerDay)
                .keyboardType(.numberPad)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.bottom, 20)
            
            Button(action: {
                currentStep = 3
            }) {
                Text("Next")
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            Spacer()
        }
    }
}

struct OnboardingStep2View_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingStep2View(currentStep: .constant(2), isOnboardingComplete: .constant(false))
    }
}
