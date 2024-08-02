//
//  ChangePasswordView.swift
//  Sennight
//
//  Created by 한유진 on 7/30/24.
//

import SwiftUI

struct ChangePasswordView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    @StateObject private var updateUserViewModel = UpdateUserViewModel()
    
    @State private var currentPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @Environment(\.presentationMode) private var presentationMode
    
    private var isUpdateDisabled: Bool {
        currentPassword.isEmpty ||
        isCurrentPasswordCorrect ||
        updateUserViewModel.password.isEmpty ||
        updateUserViewModel.password != confirmPassword ||
        !isPasswordLengthValid ||
        !hasLetter ||
        !hasDigit ||
        currentPassword != loginViewModel.password
    }
    
    private var isCurrentPasswordCorrect: Bool {
        currentPassword == loginViewModel.password
    }
    
    private var isPasswordLengthValid: Bool {
        updateUserViewModel.password.count >= 8 && updateUserViewModel.password.count <= 32
    }
    
    private var hasLetter: Bool {
        updateUserViewModel.password.rangeOfCharacter(from: .letters) != nil
    }
    
    private var hasDigit: Bool {
        updateUserViewModel.password.rangeOfCharacter(from: .decimalDigits) != nil
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Change Password")
                .font(.title)
                .bold()
                .padding(.bottom, 20)
            
            Group {
                SecureField("Current Password", text: $currentPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                if currentPassword.count >= 8 && !isCurrentPasswordCorrect {
                    Text("The current password does not match. Please make sure you’ve entered it correctly.")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                
                SecureField("New Password", text: $updateUserViewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                if !updateUserViewModel.password.isEmpty {
                    if !isPasswordLengthValid {
                        Text("Password must be between 8 and 32 characters long.")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    } else if !hasLetter || !hasDigit {
                        Text("Password must include at least one letter and one digit.")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
                
                SecureField("Confirm New Password", text: $confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                if confirmPassword.count >= 8 &&
                    updateUserViewModel.password != confirmPassword {
                    Text("Passwords do not match.")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
            
            Button(action: {
                updateUserViewModel.updatePassword { response in
                    if let newPassword = response.data?.password {
                        loginViewModel.password = newPassword
                    }
                    if response.status {
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        alertMessage = "Failed to update password. Please try again."
                        showAlert = true
                    }
                }
            }) {
                Text("Update Password")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isUpdateDisabled ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .disabled(isUpdateDisabled)
        }
        .padding()
        .navigationTitle("Change Password")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Error"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

#Preview {
    ChangePasswordView()
        .environmentObject(LoginViewModel())
}
