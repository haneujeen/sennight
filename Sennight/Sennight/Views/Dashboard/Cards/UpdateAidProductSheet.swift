//
//  UpdateFactorSheet.swift
//  Sennight
//
//  Created by 한유진 on 6/28/24.
//  Edited by 한유진 on 2024-07-19: UpdateFactorSheet.swift 파일 이름 수정
//

import SwiftUI

struct UpdateAidProductSheet: View {
    @Binding var isPresentingUpdateFactorSheet: Bool
    
    var body: some View {
        Text("Update factor sheet")
    }
}

#Preview {
    UpdateAidProductSheet(isPresentingUpdateFactorSheet: .constant(true))
}
