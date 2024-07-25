//
//  SplashScreenView.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 한유진 on 2024-07-19: 바탕화면과 로고 애니메이션 추가
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isAnimated = false
    @State private var showLogo = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: isAnimated ? [Theme.lavender.mainColor, Theme.buttercup.mainColor] : [Theme.indigo.mainColor, Theme.navy.mainColor]),
                startPoint: .topTrailing,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                withAnimation(.easeInOut(duration: 1.5)) {
                    isAnimated.toggle()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                    withAnimation(.easeIn(duration: 0.7)) {
                        showLogo = true
                    }
                }
            }
            
            if showLogo {
                Image("logo")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .transition(.blurReplace)
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
