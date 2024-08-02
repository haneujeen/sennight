//
//  CustomTextFieldStyle.swift
//  Sennight
//
//  Created by 한유진 on 7/20/24.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(15)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color.white)
            )
    }
}

struct CustomGrayTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(15)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color.gray.opacity(0.2))
            )
    }
}
