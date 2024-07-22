//
//  OnboardingStep2View.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 한유진 on 2024-07-22: Onboarding step 1 view UI 추가
//

import SwiftUI

struct OnboardingStep1View: View {
    @Binding var currentStep: Int
    @State private var showDetails = false
    @State private var showDetail1 = false
    @State private var showDetail2 = false
    @State private var showDetail3 = false
    @State private var showDetail4 = false
    @State private var showFireworks = false
    
    var body: some View {
        ZStack {
            LottieView(name: Constants.welcomeConfetti, animationSpeed: 0.8, contentMode: .top)
            
            if showFireworks {
                GeometryReader { geometry in
                    LottieView(name: Constants.poppyFireworks, animationSpeed: 0.3, contentMode: .top)
                        .scaleEffect(0.5)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 3)
                }
            }
            
            VStack {
                Spacer()
                Text("Welcome to Sennight!")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [Theme.poppy.mainColor, Theme.bubblegum.mainColor]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .padding(.top, 30)
                
                if showDetails {
                    VStack {
                        if showDetail1 {
                            HStack(alignment: .top) {
                                Image(systemName: "chart.line.downtrend.xyaxis")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .foregroundStyle(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Theme.poppy.mainColor, Theme.bubblegum.mainColor]),
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                
                                VStack(alignment: .leading) {
                                    Text("Track Habits and Cravings")
                                        .fontWeight(.semibold)
                                    Text("Add and manage your smoking habits and cravings.")
                                        .font(.subheadline)
                                        .foregroundStyle(Color.secondary)
                                }
                                .padding(.leading, 10)
                                Spacer()
                            }
                            .padding(.bottom)
                        }
                        
                        if showDetail2 {
                            HStack(alignment: .top) {
                                Image(systemName: "signpost.right.and.left")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 45, height: 45)
                                    .foregroundStyle(Theme.bubblegum.mainColor)
                                
                                VStack(alignment: .leading) {
                                    Text("Start Your Quitting Log")
                                        .fontWeight(.semibold)
                                    Text("Begin your journey and stay updated with your progress.")
                                        .font(.subheadline)
                                        .foregroundStyle(Color.secondary)
                                }
                                .padding(.leading, 5)
                                Spacer()
                            }
                            .padding(.bottom)
                        }
                        
                        if showDetail3 {
                            HStack(alignment: .top) {
                                Image(systemName: "face.dashed.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .foregroundStyle(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Theme.bubblegum.mainColor, Theme.periwinkle.mainColor]),
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                
                                VStack(alignment: .leading) {
                                    Text("Feelings and Symptoms")
                                        .fontWeight(.semibold)
                                    Text("Keep track of your emotions and withdrawal symptoms.")
                                        .font(.subheadline)
                                        .foregroundStyle(Color.secondary)
                                }
                                .padding(.leading, 10)
                                Spacer()
                            }
                            .padding(.bottom)
                        }
                        
                        if showDetail4 {
                            HStack(alignment: .top) {
                                Image(systemName: "heart.text.square")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .foregroundStyle(Theme.periwinkle.mainColor)
                                
                                VStack(alignment: .leading) {
                                    Text("Share Your Milestones")
                                        .fontWeight(.semibold)
                                    Text("Support and get support from others who are also on this journey.")
                                        .font(.subheadline)
                                        .foregroundStyle(Color.secondary)
                                }
                                .padding(.leading, 10)
                                Spacer()
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 40)
                    .transition(.blurReplace)
                }
                
                Spacer()
                
                Button(action: {
                    currentStep = 2
                }) {
                    Text("Next")
                        .fontWeight(.semibold)
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(
                            gradient: Gradient(colors: [Theme.periwinkle.mainColor, Theme.sky.mainColor]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .foregroundColor(Theme.periwinkle.accentColor)
                        .cornerRadius(25)
                }
                .padding()
            }
            .padding()
            .foregroundStyle(Theme.indigo.mainColor)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.easeIn(duration: 0.7)) {
                        showDetails = true
                        showDetail1 = true
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                    withAnimation(.easeIn(duration: 1)) {
                        showDetail2 = true
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
                    withAnimation(.easeIn(duration: 1.5)) {
                        showDetail3 = true
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                    withAnimation(.easeIn(duration: 2)) {
                        showDetail4 = true
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
                    withAnimation() {
                        showFireworks = true
                    }
                }
            }
        }
    }
}

struct OnboardingStep1View_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingStep1View(currentStep: .constant(1))
    }
}
