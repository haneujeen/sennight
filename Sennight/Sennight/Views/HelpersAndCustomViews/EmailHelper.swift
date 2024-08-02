//
//  EmailHelper.swift
//  CarLicenceExam
//
//  Created by Yoyo on 2/7/21.
//

import SwiftUI
import MessageUI

class EmailHelper: NSObject {
    /// Singleton instance
    static let shared = EmailHelper()
    private override init() {}
}

extension EmailHelper {
    /// Remember to add the following to Info.plist
    ///    <key>LSApplicationQueriesSchemes</key>
    ///    <array>
    ///       <string>googlegmail</string>
    ///    </array>
    func send(subject: String, body: String, to: [String]) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            return
        }

        if !MFMailComposeViewController.canSendMail() {
            let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let mails = to.joined(separator: ",")
            let alert = UIAlertController(title: "Unable to Send Email", message: "", preferredStyle: .actionSheet)
            var hasExternalMailOptions = false

            if let defaultMailUrl = URL(string: "mailto:\(mails)?subject=\(subjectEncoded)&body=\(bodyEncoded)"),
               UIApplication.shared.canOpenURL(defaultMailUrl) {
                hasExternalMailOptions = true
                alert.addAction(UIAlertAction(title: "Mail App", style: .default, handler: { (action) in
                    UIApplication.shared.open(defaultMailUrl)
                }))
            }

            if let gmailUrl = URL(string: "googlegmail://co?to=\(mails)&subject=\(subjectEncoded)&body=\(bodyEncoded)"),
               UIApplication.shared.canOpenURL(gmailUrl) {
                hasExternalMailOptions = true
                alert.addAction(UIAlertAction(title: "Gmail", style: .default, handler: { (action) in
                    UIApplication.shared.open(gmailUrl)
                }))
            }

            if hasExternalMailOptions {
                alert.message = "You can open an external email app to send your message."
            } else {
                alert.message = "No email account is set up. Please add an email account in Settings to send an email."
                if let settingsUrl = URL(string: UIApplication.openSettingsURLString),
                   UIApplication.shared.canOpenURL(settingsUrl) {
                    alert.addAction(UIAlertAction(title: "Open Settings", style: .default, handler: { (action) in
                        UIApplication.shared.open(settingsUrl)
                    }))
                }
            }

            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            rootViewController.present(alert, animated: true, completion: nil)
            return
        }

        let mailCompose = MFMailComposeViewController()
        mailCompose.setSubject(subject)
        mailCompose.setMessageBody(body, isHTML: false)
        mailCompose.setToRecipients(to)
        mailCompose.mailComposeDelegate = self
        rootViewController.present(mailCompose, animated: true, completion: nil)
    }
}

// MARK: - MFMailComposeViewControllerDelegate
extension EmailHelper: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
