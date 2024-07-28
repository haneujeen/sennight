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
        dateFormatter.date(from: quitAttemptViewModel.activeQuitAttempt?.startDate ?? "") ?? Date()
    }
    
    var body: some View {
        Section {
            if quitAttemptViewModel.isActiveQuitAttempt {
                VStack {
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
                    .font(.system(size: 26))
                    if currentDate.timeIntervalSince(startDate) > 86400 {
                        Spacer()
                        HStack {
                            Text(elapsedTimeStringHours(from: startDate, to: currentDate))
                            Text(elapsedTimeStringMinutes(from: startDate, to: currentDate))
                            Text(elapsedTimeStringSeconds(from: startDate, to: currentDate))
                        }
                    } else {
                        Spacer()
                        HStack {
                            Text(elapsedTimeStringHours(from: startDate, to: currentDate))
                            Text(elapsedTimeStringMinutes(from: startDate, to: currentDate))
                            Text(elapsedTimeStringSeconds(from: startDate, to: currentDate))
                        }
                        .font(.system(size: 24))
                    }
                }
                .onAppear(perform: {
                    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                        self.currentDate = Date()
                    }
                })
            } else {
                VStack {
                    Text("It's tough. So are you.")
                    Text("Start quitting today!")
                }
            }
        }
        .accessibilityAddTraits(.isHeader)
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

struct ElapsedTimeTextHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ElapsedTimeTextHeaderView()
            .previewLayout(.fixed(width: 400, height: 60))
            .environmentObject(QuitAttemptViewModel())
    }
}
