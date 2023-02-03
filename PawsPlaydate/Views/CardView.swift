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
            AsyncImage(url: URL(string: pet.imageURLString)) { image in
                image
                    .resizable()      // Error here
                    .frame(width: 300, height: 300)
            } placeholder: {
                //put your placeholder here
            }
//            Divider()
            Spacer()
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
//        .background(Color.gray)
//        .frame(alignment: .leading)

    }
}
