//
//  QuitAttemptMenu.swift
//  Sennight
//
//  Created by 한유진 on 7/28/24.
//

import SwiftUI

struct QuitAttemptMenu: View {
    @EnvironmentObject var quitAttemptViewModel: QuitAttemptViewModel
    
    @State private var isEditSheetPresented = false
    @State private var selectedDate = Date()
    @State private var isStopAlertPresented = false

    var body: some View {
        Menu {
            Button {
                isEditSheetPresented = true
            } label: {
                Text("Edit This Quit Log")
            }
            
            Button(role: .destructive) {
                isStopAlertPresented = true
            } label: {
                Text("Stop This Quit Log")
            }
        } label: {
            HStack {
                Image(systemName: "ellipsis")
                Text("Menu")
            }
            .frame(width: 60.0)
                .font(.footnote)
                .foregroundStyle(Theme.poppy.mainColor)
                .padding(8)
                .background(Theme.poppy.mainColor.opacity(0.3))
                .cornerRadius(10)
        }
        .sheet(isPresented: $isEditSheetPresented) {
            EditQuitAttemptSheet(selectedDate: $selectedDate, isEditSheetPresented: $isEditSheetPresented)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.hidden)
                .environmentObject(quitAttemptViewModel)
        }
        .alert("Stop My Progress", isPresented: $isStopAlertPresented) {
            Button("Cancel", role: .cancel) { }
            Button("Stop", role: .destructive) {
                guard let activeQuitAttempt = quitAttemptViewModel.activeQuitAttempt else { return }
                quitAttemptViewModel.startDate = activeQuitAttempt.startDate
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                quitAttemptViewModel.endDate = dateFormatter.string(from: Date())
                quitAttemptViewModel.isActive = false
                
                quitAttemptViewModel.updateQuitAttempt { _ in
                    
                }
                quitAttemptViewModel.activeQuitAttempt = nil
                quitAttemptViewModel.isActiveQuitAttempt = false
            }
        } message: {
            Text("This will erase your current progress and reset all health improvements.\nThis action cannot be undone.")
        }
    }
}

#Preview {
    QuitAttemptMenu()
}
