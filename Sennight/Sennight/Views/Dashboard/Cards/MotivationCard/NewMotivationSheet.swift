//
//  NewMotivationSheet.swift
//  Sennight
//
//  Created by 한유진 on 8/2/24.
//

import SwiftUI

struct NewMotivationSheet: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var motivationViewModel: MotivationViewModel
    let categories = ["Health", "Family/Relationship", "Personal", "Environment", "Add My Motivation"]
    
    @State private var selectedCategory: String = "Health"
    @State private var selectedMotivation: Motivation?
    @State private var customMotivation = ""
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var filteredMotivations: [Motivation] {
        return Motivation.allCases.filter { $0.category == selectedCategory }
    }
    
    @Binding var currentMotivation: Motivation?
    
    var body: some View {
        NavigationView {
            ScrollView {
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
                    }
                } else {
                    TextField("Add your own motivation", text: $customMotivation)
                        .textFieldStyle(CustomGrayTextFieldStyle())
                        .padding()
                        .padding(.vertical, 50)
                }
                
                Spacer()
                
            }
            .navigationBarTitle("My Motivation", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Close")
                },
                trailing: Button(action: {
                    /// Incorrect input cases
                    if selectedCategory == "Add My Motivation" && customMotivation.isEmpty {
                        print("????")
                        //alertMessage = "Please enter your motivation."
                        //showAlert = true
                    } else if selectedCategory != "Add My Motivation" && selectedMotivation == nil {
                        //alertMessage = "Please select your motivation."
                        //showAlert = true
                    } else { /// Correct input cases
                        if selectedCategory == "Add My Motivation" {
                            motivationViewModel.message = customMotivation
                            motivationViewModel.motivationID = 99
                        } else {
                            motivationViewModel.message = selectedMotivation?.message
                            motivationViewModel.motivationID = selectedMotivation?.id ?? 2
                        }
                        motivationViewModel.createMotivation { status in
                            if status {
                                motivationViewModel.getMotivation { status in
                                    if status {
                                        currentMotivation = Motivation.allCases.first(where: { $0.id == motivationViewModel.motivation?.motivationId })
                                    }
                                }
                            }
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }) {
                    Text("Save")
                        .bold()
                        .foregroundStyle(.blue)
                }
            )
            .padding()
        }
    }
}

#Preview {
    NewMotivationSheet(currentMotivation: .constant(Motivation.health2))
        .environmentObject(MotivationViewModel())
}
