//
//  QuitAttemptCardView.swift
//  Sennight
//
//  Created by 한유진 on 7/26/24.
//

import SwiftUI

struct QuitAttemptCardView: View {
    @EnvironmentObject var quitAttemptViewModel: QuitAttemptViewModel
    @State private var isShowingSheet = false
    
    @Binding var showConfetti: Bool
    @State private var showAlert = false
    var alertTitles = ["Good Start!", "On a Roll!", "Great Start!"]
    var alertMessages = [
        "You’re doing great. Keep it up!",
        "Every step counts. You’re making progress!",
        "Awesome start! Stay strong and keep going!"
    ]
    
    var body: some View {
        ZStack {
            if quitAttemptViewModel.isActiveQuitAttempt {
                HealthProgressCardView()
                    .environmentObject(quitAttemptViewModel)
            } else {
                HealthProgressCardView()
                    .blur(radius: 8)
                VStack {
                    Spacer()
                    Button(action: {
                        if !showConfetti {
                            showConfetti = true
                        }
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                        quitAttemptViewModel.startDate = dateFormatter.string(from: Date())
                        quitAttemptViewModel.createQuitAttempt { status in
                            if status {
                                quitAttemptViewModel.getActiveQuitAttempt()
                            }
                        }
                        showAlert = showAlert ? false : true
                    }) {
                        Text("Start my first day")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(20)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(25)
                    }
                    Spacer()
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitles.randomElement()!), message: Text(alertMessages.randomElement()!), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    QuitAttemptCardView(showConfetti: .constant(true))
        .environmentObject(QuitAttemptViewModel())
        .previewLayout(.fixed(width: 400, height: 320))
}
