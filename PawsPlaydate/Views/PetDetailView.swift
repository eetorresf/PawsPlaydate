//
//  PetDetailView.swift
//  PawsPlaydate
//
//  Created by Erika Dey on 1/26/23.
//

import SwiftUI
import Combine
import PhotosUI
import FirebaseAuth


struct PetDetailView: View {
    @EnvironmentObject var petVM: PetViewModel
    
    @State var pet: Pet
    @Environment(\.dismiss) private var dismiss
    
    @State private var image = UIImage()
    @State private var isTapped = true
//    @State private var showingSheet = false
    
    private let auth = Auth.auth()
    var uuid: String? {
        auth.currentUser?.uid
    }
    
    var  body: some View {
        if isTapped {
                Form {
                    Section(header: Text("Pet's Information")) {
                        VStack {
                            TextField("Pet's Name", text: $pet.petName)
                            TextField("Breed", text: $pet.breed)
                            TextField("Age", text: $pet.age)
                                .keyboardType(.numberPad)
                                .onReceive(Just(pet.age)){ newValue in
                                    let filtered = newValue.filter {"0123456789" .contains($0)}
                                    if filtered != newValue {
                                        self.pet.age = filtered
                                    }
                                }
                            Section(header: Text("About")){
                                Toggle("Spayed/Neutered", isOn: $pet.fixed)
                                    .toggleStyle(SwitchToggleStyle(tint: .purple))
                            }
                            Section(header: Text("Sex")){
                                VStack(spacing: 20) {
                                    HStack {
                                        SelectButton(isSelected: $pet.isMale, color: .purple, text: "Male")
                                            .onTapGesture {
                                                pet.isMale.toggle()
                                                if pet.isMale {
                                                    pet.isFemale = false
                                                }
                                            }
                                        SelectButton(isSelected: $pet.isFemale, color: .purple, text: "Female")
                                            .onTapGesture {
                                                pet.isFemale.toggle()
                                                if pet.isFemale {
                                                    pet.isMale = false
                                                }
                                            }
                                    }
                                }
                            }
                            .listRowBackground(Color(UIColor.systemGroupedBackground))
                            Section(header: Text("Bio")){
                                TextField("Tell us about your pet", text: $pet.bio, axis: .vertical)
                                    .lineLimit(5...10)
                            }
                        }
                        .navigationTitle("Create Profile")

                        .toolbar {
                            ToolbarItemGroup(placement: .navigationBarTrailing) {
                                Button("Next") {
                                    petVM.createPet(petName: pet.petName, breed: pet.breed, age: pet.age, fixed: pet.fixed, isMale: pet.isMale, isFemale: pet.isFemale, bio: pet.bio, imageURLString: pet.imageURLString) { uuid in
                                        DispatchQueue.main.async {
//                                            petId = uuid
                                            isTapped.toggle()
                                        }
                                    }
                                }
                                .foregroundColor(Color.blue)
                                }
                            }
                            
                        }
                    }
        } else {
            PhotoDetailView(petVM: petVM)
        }
        }
        
    }

