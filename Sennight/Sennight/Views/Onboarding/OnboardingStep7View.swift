//
//  OnboardingStep7View.swift
//  Sennight
//
//  Created by 한유진 on 7/16/24.
//  Edited by 김소연 on 2024-07-23:
//    UI수정
//

import SwiftUI

struct OnboardingStep7View: View {
    @EnvironmentObject var quitAttemptViewModel: QuitAttemptViewModel
    @Binding var currentStep: Int
    @Binding var isOnboardingComplete: Bool
    
    @State private var selectedDate = Date()
    private var today: Date {
        return Calendar.current.startOfDay(for: Date())
    }
    
    var body: some View {
        VStack {
            OnboardingDismissButton(isOnboardingComplete: $isOnboardingComplete)
            
            HStack {
                Text("Let us know")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [Theme.sky.mainColor, Theme.teal.mainColor]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                Text("the date you quit smoking.")
                    .padding(.leading)
                    .fontWeight(.semibold)
                Spacer()
            }
            
            HStack {
                Text("We’ll track your progress and milestones.")
                    .padding(.horizontal)
                    .font(.subheadline)
                    .foregroundStyle(Color.secondary)
                Spacer()
            }
            
            DatePicker("Select Date", selection: $selectedDate, in: ...today, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .accentColor(.brown)
                .padding(.horizontal)
                .padding(.vertical, 30)
            
            Button(action: {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let selectedDateString = dateFormatter.string(from: selectedDate)
                quitAttemptViewModel.startDate = selectedDateString
                currentStep = 8
            }) {
                Text("Next")
                    .fontWeight(.semibold)
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(
                        gradient: Gradient(colors: [Theme.teal.mainColor, Theme.sky.mainColor]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .foregroundColor(Theme.periwinkle.accentColor)
                    .cornerRadius(25)
            }
            .padding(.horizontal)
            
            Button(action: {
                currentStep = 6
            }) {
                Text("Previous")
                    .fontWeight(.semibold)
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(Theme.lightGray.mainColor)
                    .cornerRadius(25)
            }
            .padding(.horizontal)
            Spacer()
        }
        .foregroundStyle(Theme.indigo.mainColor)
        .padding()
    }
    
    // 선택된 날짜를 포맷팅하는 계산 속성
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: selectedDate)
    }
}

struct OnboardingStep7View_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingStep7View(currentStep: .constant(7), isOnboardingComplete: .constant(false))
            .environmentObject(QuitAttemptViewModel())
    }
}
