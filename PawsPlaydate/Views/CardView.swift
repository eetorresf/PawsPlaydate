//
//  CardView.swift
//  PawsPlaydate
//
//  Created by Erika Dey on 2/2/23.
//

import SwiftUI

struct CardView: View {
    let pet: Pet
    var body: some View {
        VStack(alignment: .leading) {
            Text(pet.petName)
                .font(.headline)
            Divider()
            VStack {
                
            }
            VStack{
                Text(pet.breed)
                Text("Age: ")
                + Text(pet.age)
                Text("")
                + Text(pet.isFemale ? "Female" : "")
                + Text(pet.isMale ? "Male" : "")
                Text("Spayed/Neutered: ")
                + Text(pet.fixed ? "Yes" : "No")
                Text(pet.bio)
            }
            .font(.caption)
        }
        .padding()
//        .foregroundColor(Color.gray)
        .frame(alignment: .leading)

    }
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//    }
//}
