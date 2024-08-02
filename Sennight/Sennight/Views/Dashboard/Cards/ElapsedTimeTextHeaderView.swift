//
//  DashboardHeaderView.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//

import SwiftUI

struct ElapsedTimeTextHeaderView: View {
    @EnvironmentObject var quitAttemptViewModel: QuitAttemptViewModel
    @State private var currentDate = Date()
    
    private var startDate: Date {
        dateFormatter().date(from: quitAttemptViewModel.activeQuitAttempt?.startDate ?? "") ?? Date()
    }
    
    var body: some View {
        Section {
            if quitAttemptViewModel.isActiveQuitAttempt {
                VStack {
                    Image(systemName: "timer")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .padding(.bottom, -10)
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Theme.poppy.mainColor, Theme.periwinkle.mainColor]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    HStack {
                        if currentDate.timeIntervalSince(startDate) > 31_536_000 {
                            Text(elapsedTimeStringYears(from: startDate, to: currentDate))
                        }
                        if currentDate.timeIntervalSince(startDate) > 2_592_000 {
                            Text(elapsedTimeStringMonths(from: startDate, to: currentDate))
                        }
                        if currentDate.timeIntervalSince(startDate) > 86400 {
                            Text(elapsedTimeStringDays(from: startDate, to: currentDate))
                        }
                    }
                    .font(.system(size: 27))
                    .fontWeight(.heavy)
                    .foregroundStyle(Theme.periwinkle.mainColor)
                    
                    HStack {
                        Text(elapsedTimeStringHours(from: startDate, to: currentDate))
                        Text(elapsedTimeStringMinutes(from: startDate, to: currentDate))
                        Text(elapsedTimeStringSeconds(from: startDate, to: currentDate))
                    }
                    .font(currentDate.timeIntervalSince(startDate) <= 86400 ? .system(size: 22) : .footnote)
                    .padding(.top, currentDate.timeIntervalSince(startDate) <= 86400 ? 20 : 0)
                    .fontWeight(currentDate.timeIntervalSince(startDate) <= 86400 ? .heavy : .regular)
                    .foregroundStyle(currentDate.timeIntervalSince(startDate) <= 86400 ? Theme.periwinkle.mainColor : Theme.indigo.mainColor)
                    
                }
                .onAppear(perform: {
                    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                        self.currentDate = Date()
                    }
                })
            } else {
                VStack {
                    Image(systemName: "cloud.rainbow.half")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .padding(.bottom, -10)
                    Text("It's tough. So are you.")
                        .font(.title3)
                    Text("START QUITTING TODAY!")
                        .font(.system(size: 27))
                }
                .italic()
                .fontWeight(.black)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Theme.periwinkle.mainColor, Theme.lightBlue.mainColor]), startPoint: .topLeading, endPoint: .bottomTrailing))
            }
        }
        .accessibilityAddTraits(.isHeader)
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

struct ElapsedTimeTextHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ElapsedTimeTextHeaderView()
            .previewLayout(.fixed(width: 400, height: 80))
            .environmentObject(QuitAttemptViewModel())
    }
}
