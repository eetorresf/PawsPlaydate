//
//  MyLikedPetsView.swift
//  PawsPlaydate
//
//  Created by Erika Dey on 2/7/23.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct MyLikedPetsView: View {
    
    @ObservedObject var petVM = PetViewModel()
    
    var body: some View {
        List(petVM.pets) { pet in
            
            myCardView(pet: pet)
                .listStyle(.plain)
        }
    }
    
    init() {
        petVM.fetchLikedPets()
}
}


