//
//  EditProfileView.swift
//  PawsPlaydate
//
//  Created by Erika Dey on 1/26/23.
//

import SwiftUI
import Combine
import PhotosUI

struct EditProfileView: View {
    @EnvironmentObject var petVM: PetViewModel
    @State var pet: Pet
    @Environment(\.dismiss) private var dismiss
    
    
    @State private var isMale = false
    @State private var isFemale = false
    
    
    @State var changeProfileImage = false
    @State var openCameraRoll = false
    @State var imageSelected = UIImage()
    @State private var selectedPhoto: PhotosPickerItem?

    
    var body: some View {
        NavigationView {
            
            
            Form {
                Section(header: Text("Photo")){
                    ZStack(alignment: .bottomTrailing){
                        Button(action: {
                            changeProfileImage = true
                            openCameraRoll = true
                        }, label: {
                            if changeProfileImage {
                                Image(uiImage: imageSelected)
                                    .resizable()
                                    .frame(width: 120, height: 120)
                            } else {
                                Image("dog")
                                    .resizable()
                                    .frame(width: 120, height: 120)
                                    .background(Color.gray)
                            }
                        })
                        Image(systemName: "plus")
                            .frame(width: 30, height: 30)
                            .foregroundColor(.purple)
                            .background(Color.white)
                            .clipShape(Circle())
                    }
                    .sheet(isPresented: $openCameraRoll) {
                        ImagePicker(selectedImage: $imageSelected, sourceType: .photoLibrary)
                    }
                }
//                Section(header: Text("Photo")) {
//                    PhotosPicker(selection: $selectedPhoto, matching: .images, preferredItemEncoding: .automatic) {
//                        Image("dog")
//                        Text("Photo")
//                    }
//                }
                Section(header: Text("Pet's Information")){
                    TextField("Pet Name", text: $pet.petName)
                    TextField("Breed", text: $pet.breed)
                    TextField("Age", text: $pet.age)
                        .keyboardType(.numberPad)
                        .onReceive(Just(pet.age)) {newValue in
                            let filtered = newValue.filter { "0123456789".contains($0)}
                            if filtered != newValue {
                                self.pet.age = filtered
                            }
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
                                    isMale.toggle()
                                    
                                    if isMale {
                                        pet.isFemale = false
                                    }
                                }
                            SelectButton(isSelected: $pet.isFemale, color: .purple, text: "Female")
                                .onTapGesture {
                                    isFemale.toggle()
                                    
                                    if isFemale {
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
            .navigationTitle("Edit Profile")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        //                            hideKeyboard()
                    } label: {
                        Image(systemName: "keyboard.chevron.compact.down")
                    }
//                    Button("Save") {
//                        Task {
//                            let success = await petVM.addPet(pet: pet)
//                            if success {
//                                dismiss()
//                            } else {
//                                print("sad")
//                            }
//
//                        }
//                    }
//                    Button(action: {
//                        petVM.createPet(petName: petName, breed: breed, age: age, fixed: fixed, isMale: isMale, isFemale: isFemale, bio: bio, user: <#String#>)
//                    }) {
//                        Text("Add Pet")
                    }
                }
                
            }
        }
        
    }
//}


//extension View {
//    func hideKeyboard() {
//        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//    }
//}
