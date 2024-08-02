//
//  PrivacyPolicyView.swift
//  Sennight
//
//  Created by 한유진 on 7/30/24.
//

import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("1. Introduction")
                    .font(.headline)
                Text("Welcome to Sennight (\"Sennight\"). We are committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our iOS application. By using Sennight, you agree to the collection and use of information in accordance with this policy.")
                
                Text("2. Information We Collect")
                    .font(.headline)
                Text("We may collect and use the following types of information:")
                
                Text("- **Personal Information**: Information that identifies you personally, such as your name, email address, or other contact details.")
                Text("- **Usage Data**: Information about how you use the App, including your interactions with features and services.")
                Text("- **Device Information**: Information about your device, such as your device ID, operating system, and other technical details.")
                
                Text("3. How We Use Your Information")
                    .font(.headline)
                Text("We use the information we collect for various purposes, including:")
                
                Text("- **To Provide and Maintain the App**: Ensuring the App functions correctly and addressing any issues.")
                Text("- **To Improve the App**: Analyzing usage patterns to enhance features and performance.")
                Text("- **To Communicate with You**: Sending updates, notifications, and other information related to the App.")
                Text("- **To Comply with Legal Obligations**: Adhering to applicable laws and regulations.")
                
                Text("4. How We Share Your Information")
                    .font(.headline)
                Text("We do not sell or rent your personal information to third parties. We may share your information in the following circumstances:")
                
                Text("- **With Service Providers**: We may share your information with third-party service providers who assist us in operating the App and providing services.")
                Text("- **For Legal Reasons**: We may disclose your information if required to do so by law or to protect our rights, privacy, safety, or property.")
                
                Text("5. Security")
                    .font(.headline)
                Text("We employ reasonable measures to protect your information from unauthorized access, use, or disclosure. However, no method of transmission over the internet or electronic storage is completely secure, and we cannot guarantee absolute security.")
                
                Text("6. Your Choices")
                    .font(.headline)
                Text("You may:")
                
                Text("- **Access and Update Your Information**: Request access to or update your personal information.")
                Text("- **Opt-Out**: Choose not to receive promotional communications from us by following the instructions in those communications.")
                
                Text("7. Children’s Privacy")
                    .font(.headline)
                Text("Sennight is not intended for use by individuals under the age of 13. We do not knowingly collect or solicit personal information from children under 13. If we become aware that we have collected such information, we will take steps to delete it.")
                
                Text("8. Changes to This Privacy Policy")
                    .font(.headline)
                Text("We may update this Privacy Policy from time to time. Any changes will be posted on this page with an updated effective date. Your continued use of the App after any changes constitutes acceptance of the new policy.")
                
                Text("10. Contact Information")
                    .font(.headline)
                Text("If you have any questions or concerns about this Privacy Policy, please contact us at [Sennight Help](mailto:eujeenhan@gmail.com).")
            }
            .padding()
        }
        .navigationTitle("Privacy Policy")
    }
}

#Preview {
    PrivacyPolicyView()
}
