//
//  CardView.swift
//  PawsPlaydate
//
//  Created by Erika Dey on 2/2/23.
//

import SwiftUI

struct CardView: View {
    
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
                HeartButton(isLiked: $isLiked, pet: pet)
                    .padding(.trailing, 20)
            }
        }
        .padding()
        
    }
}


struct HeartButton: View {

    
    @Binding var isLiked: Bool

    @State var pet: Pet
    @EnvironmentObject var petVM: PetViewModel
    
    private let animationDuration: Double = 0.1
    private var animationScale: CGFloat {
        isLiked ? 0.7 : 1.3
    }
    @State private var animate = false
    @State private var add = false
    
    var body: some View {
        Button(action: {
            self.animate = true
            self.add.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + self.animationDuration, execute: {
                if self.add == true {
                    
                    petVM.addLikedPet(pet: pet)
                    
                } else {
                    Task {
                        
                        _ = await petVM.removeLikedPet(pet: pet)
                    }
                }
                self.animate = false
                self.isLiked.toggle()
                                
            })
        }, label: {
            Image(systemName: isLiked ? "heart.fill" : "heart")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25)
                .foregroundColor(isLiked ? .red : .gray)
            //                .padding()
        })
        .scaleEffect(animate ? animationScale : 1)
        .animation(Animation.easeIn(duration: animationDuration), value: animate)
    }
}
