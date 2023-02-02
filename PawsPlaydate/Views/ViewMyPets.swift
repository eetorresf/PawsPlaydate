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
    
//    @EnvironmentObject var petVM: PetViewModel
//    @FirestoreQuery(collectionPath: "pets") var pets: [Pet]
    @ObservedObject var petVM = PetViewModel()

        var body: some View {
            List(petVM.pets) { pet in
                CardView(pet: pet)
            }

            .listStyle(.plain)
            }
    init() {
        petVM.fetchMyPets()
    }
        }
    
    
    
    
//    var body: some View {
//        List(petVM.pets) { pet in
//            VStack(alignment: .leading) {
//                Text(pet.petName)
//                    .font(.headline)
//                Text(pet.breed)
//            }
//        }
//        .navigationBarTitle("Pets")
//        .onAppear() {
//            self.petVM.fetchPets()
//        }
//
//    }

//var body: some View {
//    List(petVM.pets) { pet in
//        NavigationLink {
//            PetDetailView(pet: pet)
////                    petVM.fetchAllPets()
//        } label: {
//            Text(pet.petName)
//                .font(.title2)
//        }
//    }
//            .listStyle(.plain)
//
//    }
//}
