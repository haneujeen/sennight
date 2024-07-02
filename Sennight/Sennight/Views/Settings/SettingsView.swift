//
//  SettingsView.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        List {
            Section(header: Text("Account Settings")) {
                Text("Profile")
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                Text("Change Password")
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                Text("Subscription/Billing Information")
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                Text("Logout")
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
            }
            
            Section(header: Text("Privacy and Security")) {
                Text("App Permissions")
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                Text("Privacy Policy")
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                Text("Data Usage")
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
            }
            
            Section(header: Text("General")) {
                Text("Language")
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                Text("Time Zone")
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                Text("App Version")
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
            }
            
            Section(header: Text("Legal")) {
                Text("Terms of Service")
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                Text("Licenses")
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
            }
            
            Section(header: Text("Support")) {
                Text("About App")
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                Text("Contact Support")
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
            }
        }
    }
}

#Preview {
    SettingsView()
}
