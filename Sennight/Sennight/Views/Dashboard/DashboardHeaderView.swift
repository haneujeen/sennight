//
//  DashboardHeaderView.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//

import SwiftUI

struct DashboardHeaderView: View {
    var body: some View {
        Section {
            Text("Dashboard header")
                .accessibilityAddTraits(.isHeader)
        }
    }
}

struct DashboardHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardHeaderView()
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
