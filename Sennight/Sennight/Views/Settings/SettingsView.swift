//
//  SettingsView.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var smokingHabitViewModel: SmokingHabitViewModel
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Account Settings")) {
                    NavigationLink(destination: ProfileView().environmentObject(smokingHabitViewModel)) {
                        Text("Profile")
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                    }
                    NavigationLink(destination: Text("Change Password View")) {
                        Text("Change Password")
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                    }
                    Button(action: {
                        // Add logout action here
                    }) {
                        Text("Logout")
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                    }
                }
                
                Section(header: Text("Legal")) {
                    NavigationLink(destination: Text("Terms of Service View")) {
                        Text("Terms of Service")
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                    }
                    NavigationLink(destination: Text("Privacy Policy View")) {
                        Text("Privacy Policy")
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                    }
                    NavigationLink(destination: Text("Licenses View")) {
                        Text("Licenses")
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                    }
                }
                
                Section(header: Text("Support")) {
                    NavigationLink(destination: Text("About App View")) {
                        Text("About App")
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                    }
                    NavigationLink(destination: Text("Contact Support View")) {
                        Text("Contact Support")
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(SmokingHabitViewModel())
}
