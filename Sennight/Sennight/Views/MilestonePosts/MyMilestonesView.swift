//
//  MyMilestonesView.swift
//  Sennight
//
//  Created by 한유진 on 7/2/24.
//

import SwiftUI

struct MyMilestonesView: View {
    var body: some View {
        HStack {
            VStack {
                HStack {
                    VStack {
                        Image(systemName: "medal.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .foregroundColor(.yellow)
                        
                        Text("7 Day Fresh")
                    }
                    .padding()
                    .frame(width: 120)
                    .background(.white)
                    .cornerRadius(15)
                    
                    VStack {
                        Image(systemName: "medal.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .foregroundColor(.cyan)
                        
                        Text("30 Day Hero")
                    }
                    .padding()
                    .frame(width: 120)
                    .background(.white)
                    .cornerRadius(15)
                    
                    VStack {
                        Image(systemName: "medal.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .foregroundColor(.teal)
                        
                        Text("3 Month Fresh")
                    }
                    .padding()
                    .frame(width: 120)
                    .background(.white)
                    .cornerRadius(15)
                }
                Spacer()
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6))
    }
}

#Preview {
    MyMilestonesView()
}
