//
//  TermsAndConditionsView.swift
//  Sennight
//
//  Created by 한유진 on 7/30/24.
//

import SwiftUI

struct TermsAndConditionsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("1. Acceptance of Terms")
                    .font(.headline)
                Text("By accessing or using the Sennight (\"Sennight\"), you agree to comply with and be bound by these Terms and Conditions.")
                
                Text("2. User Accounts")
                    .font(.headline)
                Text("To access certain features of the Sennight, you may be required to create a user account. You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account.")
                
                Text("3. Use of the App")
                    .font(.headline)
                Text("You agree to use the Sennight only for lawful purposes and in accordance with these Terms. You may not use the Sennight in any way that could damage, disable, overburden, or impair the Sennight or interfere with any other party’s use of the Sennight.")
                
                Text("4. Intellectual Property")
                    .font(.headline)
                Text("All content, trademarks, and other intellectual property on the Sennight are owned by or licensed to Sennight and are protected by applicable laws. You may not use, reproduce, or distribute any content from the Sennight without explicit permission.")
                
                Text("5. Privacy")
                    .font(.headline)
                Text("Your use of the Sennight is also governed by our Privacy Policy. By using the Sennight, you consent to the collection and use of your information as described in the Privacy Policy.")
                    .foregroundColor(.blue)
                    .underline()
                
                Text("6. Third-Party Links")
                    .font(.headline)
                Text("The Sennight may contain links to third-party websites or services. We are not responsible for the content, privacy policies, or practices of any third-party sites.")
                
                Text("7. Disclaimer")
                    .font(.headline)
                Text("The Sennight is provided on an “as is” and “as available” basis. We make no warranties or representations regarding the availability, accuracy, or reliability of the Sennight. We disclaim all warranties to the fullest extent permitted by law.")
                
                Text("8. Limitation of Liability")
                    .font(.headline)
                Text("In no event shall the creators be liable for any indirect, incidental, special, or consequential damages arising from or related to your use of the Sennight.")
                
                Text("9. Changes to Terms")
                    .font(.headline)
                Text("We may update these Terms from time to time. Any changes will be posted on this page with an updated effective date. Your continued use of the App after any changes constitutes acceptance of the new terms.")
                
                Text("10. Contact Information")
                    .font(.headline)
                Text("If you have any questions or concerns about this Terms and Conditions, please contact us at [Sennight Help](mailto:eujeenhan@gmail.com).")
            }
            .padding()
        }
        .navigationTitle("Terms of Service")
    }
}
#Preview {
    TermsAndConditionsView()
}
