import SwiftUI
import AuthenticationServices

struct SignInWithAppleButton: UIViewRepresentable {
    var cornerRadius: CGFloat
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        let button = ASAuthorizationAppleIDButton(type: .continue, style: .black)
        button.cornerRadius = cornerRadius
        return button
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
        uiView.cornerRadius = cornerRadius
    }
}
