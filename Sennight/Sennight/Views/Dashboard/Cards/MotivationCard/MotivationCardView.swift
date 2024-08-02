//
//  MotivationCardView.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//

import SwiftUI

import SwiftUI

struct MotivationCardView: View {
    @StateObject var motivationViewModel = MotivationViewModel()
    
    @State var showSheet = false
    @Binding var isLoading: Bool
    
    @State private var currentMotivation: Motivation?
    
    var body: some View {
        Section {
            Button(action: {
                showSheet = true
            }) {
                if let motivation = currentMotivation {
                    VStack {
                        motivation.icon
                            .padding(.bottom, 1)
                        HStack(alignment: .center) {
                            Text(!motivation.message.isEmpty ? motivation.message : (motivationViewModel.motivation?.message ?? ""))
                                .lineLimit(2)
                                .font(.system(size: 14))
                                .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                        }
                    }
                } else {
                    VStack {
                        Image(systemName: "moon.stars")
                            .padding(.bottom, 1)
                        HStack {
                            Text("What inspires/motivates you? Add here.")
                                .font(.system(size: 14))
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .buttonStyle(PlainButtonStyle())
        }
        .onAppear {
            motivationViewModel.getMotivation { status in
                if status {
                    currentMotivation = Motivation.allCases.first(where: { $0.id == motivationViewModel.motivation?.motivationId })
                }
            }
        }
        .sheet(isPresented: $showSheet) {
            NewMotivationSheet(currentMotivation: $currentMotivation)
                .environmentObject(motivationViewModel)
        }
    }
}

#Preview {
    MotivationCardView(isLoading: .constant(false))
}
