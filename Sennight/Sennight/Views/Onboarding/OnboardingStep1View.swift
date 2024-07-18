//
//  OnboardingStep1View.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//

import SwiftUI

struct OnboardingStep1View: View {
    @Binding var currentStep: Int
    @Binding var isOnboardingComplete: Bool
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
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
            Text("Welcome to Sennight!")
                .font(.largeTitle)
                .padding(.bottom, 40)
            Button(action: {
                currentStep = 2
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

struct OnboardingStep1View_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingStep1View(currentStep: .constant(1), isOnboardingComplete: .constant(false))
    }
}
