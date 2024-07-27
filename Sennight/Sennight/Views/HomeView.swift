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
            
            MilestonePostsView()
                .tabItem {
                    Label("Milestones", systemImage: "tray.and.arrow.up.fill")
                }
            
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
