//
//  ViewMyPets.swift
//  PawsPlaydate
//
//  Created by Erika Dey on 1/30/23.
//

import SwiftUI

struct ViewMyPets: View {
    
    @ObservedObject private var petVM = PetViewModel()
    
    var body: some View {
        NavigationView {
            List(petVM.pets) { pet in
                VStack(alignment: .leading) {
                    Text(pet.petName)
                        .font(.headline)
                    Text(pet.breed)
                }
            }
            .navigationBarTitle("Pets")
            .onAppear() {
                self.petVM.fetchPets()
            }
        }
    }
}

