//
//  SettingsView.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var smokingHabitViewModel: SmokingHabitViewModel
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Theme.buttercup.mainColor
                    .ignoresSafeArea()
                
                List {
                    Section(header: Text("Account Settings")) {
    //                    NavigationLink(destination: ProfileView()
    //                        .environmentObject(smokingHabitViewModel)) {
    //                        Text("Profile")
    //                            .frame(maxWidth: .infinity, alignment: .leading)
    //                            .padding(.leading)
    //                            .background(Color.white)
    //                    }
    //                    NavigationLink(destination: ChangePasswordView()
    //                        .environmentObject(smokingHabitViewModel)) {
    //                        Text("Change Password")
    //                            .frame(maxWidth: .infinity, alignment: .leading)
    //                            .padding(.leading)
    //                            .background(Color.white)
    //                    }
                        Button(action: {
                            loginViewModel.logout()
                        }) {
                            Text("Logout")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                                .contentShape(Rectangle())
                        }
                    }
                    
                    Section(header: Text("Legal")) {
                        NavigationLink(destination: TermsAndConditionsView()) {
                            Text("Terms of Service")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                                .background(Color.white)
                        }
                        NavigationLink(destination: PrivacyPolicyView()) {
                            Text("Privacy Policy")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                                .background(Color.white)
                        }
                        NavigationLink(destination: LicensesView()) {
                            Text("Licenses")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                                .background(Color.white)
                        }
                    }
                    
                    Section(header: Text("Support")) {
    //                    NavigationLink(destination: Text("About App View")) {
    //                        Text("About App")
    //                            .frame(maxWidth: .infinity, alignment: .leading)
    //                            .padding(.leading)
    //                            .contentShape(Rectangle())
    //                    }
                        Button(action: {
                            if let url = URL(string: "mailto:eujeenhan@gmail.com") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            Text("[Contact Support](mailto:eujeenhan@gmail.com)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                                .foregroundColor(.blue) // Make it look like a link
                        }
                    }
                }
                .navigationTitle("Settings")
                .scrollContentBackground(.hidden)
            }
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(SmokingHabitViewModel())
        .environmentObject(LoginViewModel())
}
