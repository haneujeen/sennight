//
//  OnboardingStep2View.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 김소연 on 2024-07-22: 온보딩 스텝 2 UI 수정
//  Edited by 김소연 on 2024-07-24: selectedNum을 SmokingHabitViewModel의 dailyCigarettes에 저장
//

import SwiftUI

struct OnboardingStep2View: View {
    @EnvironmentObject var smokingHabitViewModel: SmokingHabitViewModel
    let dailyCigarettesNum = Array(0...60)
    @State private var selectedNum = 1
    @Binding var currentStep: Int
    @Binding var isOnboardingComplete: Bool
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    isOnboardingComplete = true
                }) {
                    Text("Dismiss")
                        .foregroundColor(.red)
                }
                .padding()
            }
            
            Spacer()
            Text("Step 2: daily cigarettes")
                .font(.largeTitle)
                .padding(.bottom, 40)
            
            HStack {
                Text("Q.")
                    .font(.title2)
                    .padding(.bottom, 25)
                Text("Let us know the number of cigarettes you smoke daily.")
                    .font(.title2)
                    .padding(.horizontal)
            }
            
            // Picker의 selection 바인딩과 ForEach의 item 바인딩이 일치해야 합니다.
            GeometryReader { geometry in
                Picker("", selection: $selectedNum) {
                    ForEach(dailyCigarettesNum, id: \.self) { number in
                        Text("\(number)")
                            .font(.title3)
                            .foregroundStyle(.primary)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: geometry.size.width, height: 100)
                .clipped() // 프레임을 벗어나는 이미지 제거
                .padding(.bottom, 30)
            }
            
            Button(action: {
                smokingHabitViewModel.dailyCigarettes = selectedNum
                currentStep = 3
            }) {
                Text("Next")
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            Spacer()
        }
    }
}

struct OnboardingStep2View_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingStep2View(currentStep: .constant(2), isOnboardingComplete: .constant(false))
            .environmentObject(SmokingHabitViewModel())
    }
}
