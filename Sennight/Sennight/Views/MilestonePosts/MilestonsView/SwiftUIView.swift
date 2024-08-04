//
//  SwiftUIView.swift
//  Sennight
//
//  Created by 한유진 on 8/4/24.
//

import SwiftUI

struct SwiftUIView: View {
    let numbers = Array(1...10) // Example array of numbers
        
        var body: some View {
            List {
                ForEach(0..<numbers.count / 2 + numbers.count % 2, id: \.self) { index in
                    HStack {
                        if index * 2 < numbers.count {
                            VStack {
                                Text("\(numbers[index * 2])")
                                    .frame(width: 50, height: 50)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                            }
                            .frame(maxWidth: .infinity)
                        }
                        
                        if index * 2 + 1 < numbers.count {
                            VStack {
                                Text("\(numbers[index * 2 + 1])")
                                    .frame(width: 50, height: 50)
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
        }
}

#Preview {
    SwiftUIView()
}
