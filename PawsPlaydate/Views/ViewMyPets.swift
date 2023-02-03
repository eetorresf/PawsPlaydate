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
                CardView(pet: pet)
            }

            .listStyle(.plain)
            }
    init() {
        petVM.fetchMyPets()
    }
        }
    
    
