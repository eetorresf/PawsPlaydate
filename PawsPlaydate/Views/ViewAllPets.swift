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
    

    @ObservedObject var petVM = PetViewModel()

    var body: some View {
        List(petVM.pets) { pet in
            
            CardView(pet: pet)
            
                .listStyle(.plain)
        }
    }
    init() {
        petVM.fetchAllPets()
//        petVM.retrieveImage()
    }
        }
