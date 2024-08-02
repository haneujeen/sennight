//
//  QuitAttemptMenu.swift
//  Sennight
//
//  Created by 한유진 on 7/28/24.
//

import SwiftUI

struct QuitAttemptMenu: View {
    @State private var isEditSheetPresented = false
    @State private var selectedDate = Date()
    @State private var isStopAlertPresented = false

    var body: some View {
        Menu {
            Button {
                isEditSheetPresented = true
            } label: {
                Text("Edit This Quit Attempt")
            }
            
            Button(role: .destructive) {
                isStopAlertPresented = true
            } label: {
                Text("Stop This Quit Attempt")
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
        }
        .alert("Stop Quit Attempt", isPresented: $isStopAlertPresented) {
            Button("Cancel", role: .cancel) { }
            Button("Stop", role: .destructive) {
                // Action to stop the quit attempt
                // This will stop your current quit attempt and reset all your progress.
                // This action cannot be undone.
            }
        } message: {
            Text("This will stop your current quit attempt and reset all your progress.\nThis action cannot be undone.")
        }
    }
}

#Preview {
    QuitAttemptMenu()
}
