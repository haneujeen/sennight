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
    
    var body: some View {
        ZStack {
            if quitAttemptViewModel.isActiveQuitAttempt {
                HealthProgressCardView()
            } else {
                CircularGauge(progress: 0)
                    .blur(radius: quitAttemptViewModel.isActiveQuitAttempt ? 0 : 10)
                VStack {
                    Spacer()
                    Button(action: {
                        isShowingSheet = true
                    }) {
                        Text("Get Started")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    Spacer()
                }
            }
        }
        .sheet(isPresented: $isShowingSheet) {
            NewQuitAttemptSheet()
        }
    }
}

#Preview {
    QuitAttemptCardView()
        .environmentObject(QuitAttemptViewModel())
}
