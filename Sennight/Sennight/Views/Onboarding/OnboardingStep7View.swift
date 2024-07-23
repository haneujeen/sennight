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
    // @Binding 변수들은 부모 뷰에서 전달받은 값을 양방향으로 바인딩합니다.
    @Binding var currentStep: Int
    @Binding var isOnboardingComplete: Bool
    
    // 사용자가 선택한 날짜를 저장합니다.
    @State private var selectedDate = Date()
    
    // 경고 표시를 위한 상태 변수들
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        // 전체 뷰는 수직으로 구성 요소들을 배치합니다.
        VStack {
            // 상단 Dismiss 버튼
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
            // 제목
            Text("Step 7: Quit attempt")
                .font(.largeTitle)
                .padding(.bottom, 40)
            
            // 질문
            HStack {
                Text("Q.")
                    .font(.title2)
                Text("Let us know the date you quit smoking.")
                    .font(.title2)
                    .padding(.horizontal)
            }
            .padding(.bottom, 25)
            
            // DatePicker: 사용자가 날짜를 선택할 수 있게 합니다.
            DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle()) // 달력 형태의 UI를 제공합니다.
                .padding()
            
            // 선택된 날짜 표시
            Text("Selected Date: \(formattedDate)")
                .font(.title2)
                .padding(.vertical, 20)
            
            // 다음 버튼
            Button(action: {
                // 선택된 날짜가 미래인지 확인합니다.
                if selectedDate > Date() {
                    alertMessage = "Please select a date in the past."
                    showAlert = true
                } else {
                    currentStep = 8
                }
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
    
    // 선택된 날짜를 포맷팅하는 계산 속성
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: selectedDate)
    }
}

// Xcode의 프리뷰에서 이 뷰를 볼 수 있게 합니다.
struct OnboardingStep7View_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingStep7View(currentStep: .constant(7), isOnboardingComplete: .constant(false))
    }
}
