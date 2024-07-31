//
//  OnboardingStep8View.swift
//  Sennight
//
//  Created by 한유진 on 7/16/24.
//  Edited by 김소연 on 2024-07-23: 피커의 직접입력 선택시 텍스트 필드 입력창이 나타나도록 수정
//

import SwiftUI

struct OnboardingStep8View: View {
    @EnvironmentObject var motivationViewModel: MotivationViewModel
    let categories = ["Health", "Family/Relationship", "Personal", "Environment", "Add My Motivation"]
    @State private var selectedCategory: String = "Health"
    @State private var selectedMotivation: Motivation?
    @Binding var currentStep: Int
    @Binding var isOnboardingComplete: Bool
    @State private var customMotivation = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var filteredMotivations: [Motivation] {
        return Motivation.allCases.filter { $0.category == selectedCategory }
    }
    
    var body: some View {
        VStack {
            OnboardingDismissButton(isOnboardingComplete: $isOnboardingComplete)
            
            ScrollView {
                HStack {
                    Text("Tell us what")
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
                    Text("motivated you to quit smoking?")
                        .padding(.leading)
                        .fontWeight(.semibold)
                    Spacer()
                }
                
                
                VStack {
                    HStack {
                        ForEach(["Health", "Family/Relationship"], id: \.self) { category in
                            Button(action: {
                                selectedCategory = category
                                selectedMotivation = nil
                            }) {
                                Text(category)
                                    .fontWeight(.bold)
                                    .textCase(.uppercase)
                                    .padding(12)
                                    .background(selectedCategory == category ? Theme.yellow.mainColor : Theme.lightGray.mainColor)
                                    .cornerRadius(25)
                            }
                        }
                        Spacer()
                    }
                    
                    HStack {
                        ForEach(["Personal", "Environment"], id: \.self) { category in
                            Button(action: {
                                selectedCategory = category
                                selectedMotivation = nil
                            }) {
                                Text(category)
                                    .fontWeight(.bold)
                                    .textCase(.uppercase)
                                    .padding(12)
                                    .background(selectedCategory == category ? Theme.yellow.mainColor : Theme.lightGray.mainColor)
                                    .cornerRadius(25)
                            }
                        }
                        Spacer()
                    }
                    
                    HStack {
                        Button(action: {
                            selectedCategory = "Add My Motivation"
                            selectedMotivation = nil
                        }) {
                            Text("Add My Motivation")
                                .fontWeight(.bold)
                                .textCase(.uppercase)
                                .padding(12)
                                .background(selectedCategory == "Add My Motivation" ? Theme.yellow.mainColor : Theme.lightGray.mainColor)
                                .cornerRadius(25)
                        }
                        Spacer()
                    }
                }
                .font(.caption)
                .foregroundStyle(Color.blue)
                .padding()
                
                if selectedCategory != "Add My Motivation" {
                    ForEach(filteredMotivations, id: \.self) { motivation in
                        Button(action: {
                            selectedMotivation = motivation
                        }) {
                            Text(motivation.message)
                                .lineLimit(2)
                                .font(.system(size: 18))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(selectedMotivation == motivation ? Theme.indigo.mainColor : Theme.yellow.mainColor)
                                .foregroundStyle(selectedMotivation == motivation ? .white : Theme.buttercup.accentColor)
                                .cornerRadius(25)
                        }
                        .padding(.vertical, 4)
                        .padding(.horizontal)
                    }
                } else {
                    TextField("Enter your motivation", text: $customMotivation)
                        .textFieldStyle(CustomGrayTextFieldStyle())
                        .padding()
                }
                
                
                Spacer()
                
                
                Button(action: {
                    if selectedCategory == "Add My Motivation" && customMotivation.isEmpty {
                        alertMessage = "Please enter your motivation."
                        showAlert = true
                    } else if selectedMotivation == nil {
                        alertMessage = "Please select your motivation."
                        showAlert = true
                    } else {
                        if selectedCategory == "Add My Motivation" {
                            motivationViewModel.message = customMotivation
                        }
                        motivationViewModel.motivationID = selectedMotivation?.id ?? 2
                        currentStep = 9
                    }
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
                .padding(.top)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Empty Motivation!"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                Button(action: {
                    currentStep = 6
                }) {
                    Text("Previous")
                        .fontWeight(.semibold)
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background(Theme.lightGray.mainColor)
                        .cornerRadius(25)
                }
                .padding(.horizontal)
            }
        }
        .foregroundStyle(Theme.indigo.mainColor)
        .padding()
    }
}

struct OnboardingStep8View_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingStep8View(currentStep: .constant(8), isOnboardingComplete: .constant(false))
            .environmentObject(MotivationViewModel())
    }
}
