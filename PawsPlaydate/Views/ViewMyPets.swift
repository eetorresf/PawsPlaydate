//
//  ViewMyPets.swift
//  PawsPlaydate
//
//  Created by Erika Dey on 1/30/23.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift


struct ViewMyPets: View {
    

    @ObservedObject var petVM = PetViewModel()

        var body: some View {
            List(petVM.pets) { pet in
                myCardView(pet: pet)
            }

            .listStyle(.plain)
            }
    init() {
        petVM.fetchMyPets()
    }
        }
    
    
struct myCardView: View {
    
    let pet: Pet
    @State private var isLiked = false
    
    var body: some View {
        VStack(alignment: .leading) {
                
                Text(pet.petName)
                    .font(.headline)
                AsyncImage(url: URL(string: pet.imageURLString)) { image in
                    image
                        .resizable()      // Error here
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)
                } placeholder: {
                    //put your placeholder here
                }
                Spacer()

                VStack(alignment: .leading){
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
                Spacer()

        }
        .padding()

    }
}
