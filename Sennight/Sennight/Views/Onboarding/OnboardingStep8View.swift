//
//  OnboardingStep8View.swift
//  Sennight
//
//  Created by 한유진 on 7/16/24.
//  Edited by 김소연 on 2024-07-19: UI수정: 피커의 직접입력 선택시 텍스트 필드 입력창이 나타나도록 수정
//

import SwiftUI

struct OnboardingStep8View: View {
    let motivations = ["건강을 위해", "돈을 절약하기 위해", "가족을 위해", "나 자신을 위해" ,"환경보호를 위해", "직접입력"]
    @State private var selectedMotivation = "건강을 위해"
    
    @Binding var currentStep: Int
    @Binding var isOnboardingComplete: Bool
    @State private var customMotivation = ""
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
            Text("Step 7: Motivation")
                .font(.largeTitle)
                .padding(.bottom, 40)
            
            HStack {
                Text("Q.")
                    .font(.title2)
                    .padding(.bottom, 25)
                Text("Tell us what motivated you to quit smoking?")
                    .font(.title2)
                    .padding(.horizontal)
            }
            
            Picker("", selection: $selectedMotivation) {
                ForEach(motivations, id: \.self) { motivation in
                    Text(motivation)
                        .font(.title3)
                }
            }
            .pickerStyle(.wheel)
            .frame(height: 100)
            .clipped()
            .padding(.bottom, 30)
            
            // 조건에 따라 TextField를 표시
            if selectedMotivation == "직접입력" {
                TextField("Enter your motivation", text: $customMotivation)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top, -50)
                    .padding()
            }
            
            Button(action: {
                if selectedMotivation == "직접입력" && customMotivation.isEmpty {
                    alertMessage = "Please enter your custom motivation."
                    showAlert = true
                } else {
                    isOnboardingComplete = true
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

struct OnboardingStep8View_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingStep8View(currentStep: .constant(8), isOnboardingComplete: .constant(false))
    }
}
