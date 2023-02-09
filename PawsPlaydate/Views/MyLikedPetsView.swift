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
        VStack {
            Text("Favorites")
                .font(.system(size: 24, weight: .bold))
            List(petVM.pets) { pet in
                
                myLikedPetsView(pet: pet)
                    .listStyle(.plain)
            }
        }
    }
    
    init() {
        petVM.fetchLikedPets()
}
}


struct myLikedPetsView: View {
    
    let pet: Pet
//    @ObservedObject var petVM = PetViewModel()
    
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
                
            HStack {
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
//                RemoveButton(pet: pet)
//                    .padding(.trailing, 20)
            }
            .padding()
            
        }

    }
        
}

//struct RemoveButton: View {
//    @State var pet: Pet
//    @EnvironmentObject var petVM: PetViewModel
//
//    var body: some View {
//        Button {
//            Task {
//                _ = await petVM.removeLikedPet(pet: pet)
//            }
//        } label: {
//            Image("trash")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 15)
//        }
//
//    }
//}


