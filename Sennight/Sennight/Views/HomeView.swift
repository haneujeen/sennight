//
//  HomeView.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 한유진 on 2024-07-29
//

import SwiftUI

struct HomeView: View {
    @StateObject private var quitAttemptViewModel = QuitAttemptViewModel()
    @StateObject private var smokingHabitViewModel = SmokingHabitViewModel()
    @StateObject private var loginViewModel = LoginViewModel()
    
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "tray.and.arrow.down.fill")
                }
                .environmentObject(quitAttemptViewModel)

            MyMilestonesView()
                .tabItem {
                    Label("Milestones", systemImage: "trophy")
                }
                .environmentObject(quitAttemptViewModel)
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "person.crop.circle.fill")
                }
                .environmentObject(smokingHabitViewModel)
                .environmentObject(loginViewModel)
            // TODO: Add views
//            Text("Calendar view")
//                .tabItem {
//                    Label("Dashboard", systemImage: "calendar")
//                }
//            MilestonePostsView()
//                .tabItem {
//                    Label("Milestones", systemImage: "bubble.left.and.bubble.right")
//                }
        }
    }
}

#Preview {
    HomeView()
}
