//
//  SelectButton.swift
//  PawsPlaydate
//
//  Created by Erika Dey on 1/25/23.
//

import SwiftUI

struct SelectButton: View {
    @Binding var isSelected: Bool
    @State var color: Color
    @State var text: String
    
    var body: some View {
        ZStack {
            Capsule()
                .frame(height: 30)
                .foregroundColor(isSelected ? color : .blue)
            Text(text)
                .foregroundColor(.white)
        }
    }
}

struct SelectButton_Previews: PreviewProvider {
    static var previews: some View {
        SelectButton(isSelected: .constant(false), color: .blue, text: "Option")
    }
}
