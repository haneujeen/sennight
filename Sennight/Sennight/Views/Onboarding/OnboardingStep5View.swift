//
//  OnboardingStep5View.swift
//  Sennight
//
//  Created by 한유진 on 7/16/24.
//  Edited by 김소연 on 2024-07-23: 
//    UI수정
//    다음 화면으로 넘어가지 않는 오류 수정
//

import SwiftUI

struct OnboardingStep5View: View {
    @Binding var currentStep: Int
    @Binding var isOnboardingComplete: Bool
    @State private var smokingYears = -1
    @State private var showAlert = false
    @State private var alertMessage = ""
    let selectedYears = Array(0...60)
    
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
            Text("Step 5: smoking years")
                .font(.largeTitle)
                .padding(.bottom, 40)
            HStack {
                Text("Q.")
                    .font(.title2)
                    .padding(.bottom, 25)
                Text("How many years have you been smoking?")
                    .font(.title2)
                    .padding()
            }
            .padding(.horizontal)
       
            Picker("", selection: $smokingYears) {
                ForEach(selectedYears, id: \.self) { selectedYears in
                    Text("\(selectedYears)")
                        .font(.title3)
                }
            }
            .pickerStyle(.wheel)
            .frame(height: 100)
            .clipped()
            .padding(.bottom, 30)
            
            Button(action: {
                
                if smokingYears == -1 {
                    alertMessage = "Please select the value."
                    showAlert = true
                } else {
                    currentStep = 6
                }
            }) {
                Text("Next")
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            Spacer()
        }
    }
}

struct OnboardingStep5View_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingStep5View(currentStep: .constant(5), isOnboardingComplete: .constant(false))
    }
}
