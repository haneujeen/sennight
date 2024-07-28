//
//  HomeView.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "tray.and.arrow.down.fill")
                }
//            Text("Calendar view")
//                .tabItem {
//                    Label("Dashboard", systemImage: "calendar")
//                }
            MyMilestonesView()
                .tabItem {
                    Label("Milestones", systemImage: "trophy")
                }
            
//            MilestonePostsView()
//                .tabItem {
//                    Label("Milestones", systemImage: "bubble.left.and.bubble.right")
//                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "person.crop.circle.fill")
                }
        }
    }
}

#Preview {
    HomeView()
}
