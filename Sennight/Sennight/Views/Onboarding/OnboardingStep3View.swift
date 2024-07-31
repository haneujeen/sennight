//
//  OnboardingStep3View.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//

import SwiftUI

struct OnboardingStep3View: View {
    @EnvironmentObject var smokingHabitViewModel: SmokingHabitViewModel
    @Binding var currentStep: Int
    @Binding var isOnboardingComplete: Bool
    @State private var price = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack {
            OnboardingDismissButton(isOnboardingComplete: $isOnboardingComplete)
            
            Image(systemName: "dollarsign.square")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundStyle(
                    LinearGradient(
                        gradient: Gradient(colors: [Theme.bubblegum.mainColor, Theme.sky.mainColor]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .padding()
            
            HStack {
                Text("Let us know")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [Theme.sky.mainColor, Theme.teal.mainColor]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                Text("the price of a pack of cigarettes you usually buy.")
                    .padding(.leading)
                    .fontWeight(.semibold)
                Spacer()
            }
            
            HStack {
                Text("If you’re currently smoke-free, enter the price of cigarettes you used to smoke.")
                    .padding(.horizontal)
                    .font(.subheadline)
                    .foregroundStyle(Color.secondary)
                Spacer()
            }
            
            TextField("Enter price", text: $price)
                .keyboardType(.decimalPad)
                .textFieldStyle(CustomGrayTextFieldStyle())
                .padding(.horizontal, 90)
                .padding(.vertical, 50)
            
            Button(action: {
                if !price.isEmpty, let priceValue = Double(price) {
                    smokingHabitViewModel.cigarettePrice = priceValue
                    currentStep = 4
                } else {
                    alertMessage = "Please enter a valid price."
                    showAlert = true
                }
                currentStep = 4
            }) {
                Text("Next")
                    .fontWeight(.semibold)
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(
                        gradient: Gradient(colors: [Theme.teal.mainColor, Theme.sky.mainColor]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .foregroundColor(Theme.periwinkle.accentColor)
                    .cornerRadius(25)
            }
            .padding(.horizontal)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Invalid Price"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            
            Button(action: {
                currentStep = 2
            }) {
                Text("Previous")
                    .fontWeight(.semibold)
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(Theme.lightGray.mainColor)
                    .cornerRadius(25)
            }
            .padding(.horizontal)
            Spacer()
        }
        .foregroundStyle(Theme.indigo.mainColor)
        .padding()
    }
}

struct OnboardingStep3View_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingStep3View(currentStep: .constant(3), isOnboardingComplete: .constant(false))
            .environmentObject(SmokingHabitViewModel())
    }
}
