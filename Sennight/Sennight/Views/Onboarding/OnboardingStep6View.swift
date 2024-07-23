//
//  OnboardingStep6View.swift
//  Sennight
//
//  Created by 한유진 on 7/16/24.
//  Edited by 김소연 on 2024-07-23:
//    UI 수정
//    Next 버튼을 눌렀을 때 다음 온보딩 화면으로 넘어가지 않는 오류 수정
//

import SwiftUI

struct OnboardingStep6View: View {
    @Binding var currentStep: Int
    @Binding var isOnboardingComplete: Bool
    @State private var smokingStatus: String = ""
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
            Text("Step 6: Smoking status")
                .font(.largeTitle)
                .padding(.bottom, 40)
            HStack {
                Text("Q.")
                    .font(.title2)
                Text("Are you currently a smoker?")
                    .font(.title2)
                    .padding()
            }
            .padding(.horizontal)
            
            HStack {
                Button(action: {
                    smokingStatus = "Yes"
                }, label: {
                    Text("Yes")
                })
                .padding()
                .background(smokingStatus == "Yes" ? Color.green : Color.yellow)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                Button(action: {
                    smokingStatus = "No"
                }, label: {
                    Text("No")
                })
                .padding()
                .background(smokingStatus == "No" ? Color.green : Color.yellow)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding(.bottom, 40)
            
            Button(action: {
                if smokingStatus.isEmpty {
                    alertMessage = "Please select your smoking status."
                    showAlert = true
                } else {
                    currentStep = 7
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

struct OnboardingStep6View_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingStep6View(currentStep: .constant(6), isOnboardingComplete: .constant(false))
    }
}
