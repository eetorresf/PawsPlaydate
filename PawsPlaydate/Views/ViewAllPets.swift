//
//  ViewAllPets.swift
//  PawsPlaydate
//
//  Created by Erika Dey on 2/2/23.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift


struct ViewAllPets: View {
    
//    @EnvironmentObject var petVM: PetViewModel
//    @FirestoreQuery(collectionPath: "pets") var pets: [Pet]
    @ObservedObject var petVM = PetViewModel()

        var body: some View {
            List(petVM.pets) { pet in
                if pet.isMale {
                    Text(pet.petName)
                        .font(.headline)
                    Text(pet.breed)
                        .font(.subheadline)
                    Text(pet.age)
                        .font(.subheadline)
                    Text("Male")
                } else {
                    Text(pet.petName)
                        .font(.headline)
                    Text(pet.breed)
                        .font(.subheadline)
                    Text(pet.age)
                        .font(.subheadline)
                    Text("Female")
                }
            }

            .listStyle(.plain)
            }
    init() {
        petVM.fetchAllPets()
    }
        }
    

//struct ViewAllPets_Previews: PreviewProvider {
//    static var previews: some View {
//        ViewAllPets()
//    }
//}
