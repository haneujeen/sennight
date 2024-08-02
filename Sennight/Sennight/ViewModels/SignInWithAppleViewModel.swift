import AuthenticationServices
import Combine

class SignInWithAppleViewModel: NSObject, ObservableObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    @Published var userIdentifier: String?
    @Published var userName: String = ""
    @Published var userEmail: String = ""

    private var cancellables = Set<AnyCancellable>()
    
    func startSignInWithAppleFlow() async {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        
        await withCheckedContinuation { continuation in
            self.authorizationContinuation = continuation
            authorizationController.performRequests()
        }
    }
    
    private var authorizationContinuation: CheckedContinuation<Void, Never>?
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            userIdentifier = appleIDCredential.user
            if let fullName = appleIDCredential.fullName {
                userName = "\(fullName.givenName ?? "") \(fullName.familyName ?? "")"
            }
            userEmail = appleIDCredential.email ?? ""
        }
        authorizationContinuation?.resume()
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Authorization failed: \(error.localizedDescription)")
        authorizationContinuation?.resume()
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        return window!
    }
    
    func sendAppleUserIdentifier() async -> Bool {
        guard let userIdentifier = userIdentifier else { return false }
        return await withCheckedContinuation { continuation in
            UserService.shared.sendAppleUserIdentifier(userIdentifier: userIdentifier)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error.localizedDescription)
                        continuation.resume(returning: false)
                    }
                } receiveValue: { response in
                    if response.isUserWithAppleID {
                        UserService.shared.saveToken(token: response.data?.accessToken! ?? "", userID: response.data?.id! ?? 0)
                    }
                    continuation.resume(returning: response.isUserWithAppleID)
                }.store(in: &self.cancellables)
        }
    }
}
