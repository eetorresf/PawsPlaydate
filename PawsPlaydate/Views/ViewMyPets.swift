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
    @FirestoreQuery(collectionPath: "pets") var pets: [Pet]
    @State private var sheetisPresented = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        List(pets) { pet in
            NavigationLink {
                PetDetailView()
            } label: {
                Text(pet.petName)
                    .font(.title2)
            }
        }
                .listStyle(.plain)

        }
    }
    



//var body: some View {
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
//}
