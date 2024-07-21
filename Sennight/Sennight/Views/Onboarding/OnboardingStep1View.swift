import SwiftUI

struct OnboardingStep1View: View {
    @Binding var currentStep: Int
    @Binding var isOnboardingComplete: Bool
    @State private var showDetails = false
    
    var body: some View {
        ZStack {
            LottieView(name: Constants.welcomeConfetti, loopMode: .autoReverse, contentMode: .top)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Welcome to Sennight!")
                    .foregroundStyle(Theme.indigo.mainColor)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                
                if showDetails {
                    Spacer()
                    VStack {
                        HStack(alignment: .top) {
                            Image(systemName: "chart.bar.xaxis")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                            
                            VStack(alignment: .leading) {
                                Text("Track Habits and Cravings")
                                    .fontWeight(.semibold)
                                Text("Add your smoking habits and cravings.")
                                    .font(.subheadline)
                                    .foregroundStyle(Color.secondary)
                            }
                            .padding(.leading, 5)
                            Spacer()
                        }
                        .padding(.bottom)
                        
                        HStack(alignment: .top) {
                            Image(systemName: "signpost.right.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                            
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
                        
                        HStack(alignment: .top) {
                            Image(systemName: "face.dashed")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                            
                            VStack(alignment: .leading) {
                                Text("Feelings and Symptoms")
                                    .fontWeight(.semibold)
                                Text("Keep track of your emotions and withdrawal symptoms.")
                                    .font(.subheadline)
                                    .foregroundStyle(Color.secondary)
                            }
                            .padding(.leading, 5)
                            Spacer()
                        }
                        .padding(.bottom)
                        
                        HStack(alignment: .top) {
                            Image(systemName: "heart.rectangle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                            
                            VStack(alignment: .leading) {
                                Text("Share Your Milestones")
                                    .fontWeight(.semibold)
                                Text("Support and get support from others who are also on this journey.")
                                    .font(.subheadline)
                                    .foregroundStyle(Color.secondary)
                            }
                            .padding(.leading, 5)
                            Spacer()
                        }
                    }
                    .padding(.horizontal)
                    .transition(.opacity)
                }
                
                Spacer()
                
                Button(action: {
                    currentStep = 2
                }) {
                    Text("Next")
                        .fontWeight(.semibold)
                }
                .padding(20)
                .frame(maxWidth: .infinity)
                .background(Theme.sky.mainColor)
                .foregroundColor(Theme.sky.accentColor)
                .cornerRadius(25)
                .padding()
            }
            .padding()
            .foregroundStyle(Theme.indigo.mainColor)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.easeIn(duration: 0.5)) {
                        showDetails = true
                    }
                }
            }
        }
    }
}

struct OnboardingStep1View_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingStep1View(currentStep: .constant(1), isOnboardingComplete: .constant(false))
    }
}
