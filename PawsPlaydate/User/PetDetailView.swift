//
//  PetDetailView.swift
//  PawsPlaydate
//
//  Created by Erika Dey on 1/26/23.
//

import SwiftUI
import Combine
import PhotosUI

struct PetDetailView: View {
    @EnvironmentObject var petVM: PetViewModel
    @State var pet: Pet
    @Environment(\.dismiss) private var dismiss
    
    @State var changeProfileImage = false
    @State var openCameraRoll = false
    @State var imageSelected = UIImage()
    
    @Binding var fixed: Bool
    @Binding var isMale: Bool
    @Binding var isFemale: Bool
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
//                ZStack(alignment: .bottomTrailing){
//                    Button(action: {
//                        changeProfileImage = true
//                        openCameraRoll = true
//                    }, label: {
//                        if changeProfileImage {
//                            Image(uiImage: imageSelected)
//                                .resizable()
//                                .frame(width: 120, height: 120)
//                        } else {
//                            Image("dog")
//                                .resizable()
//                                .frame(width: 120, height: 120)
//                                .background(Color.gray)
//                        }
//                    })
//                    Image(systemName: "plus")
//                        .frame(width: 30, height: 30)
//                        .foregroundColor(.purple)
//                        .background(Color.white)
//                        .clipShape(Circle())
//                }
//                .sheet(isPresented: $openCameraRoll) {
//                    PhotosPicker(selection: $selectedPhoto, matching: .images, preferredItemEncoding: .automatic)
//
//                }
                Section(header:Text("Pet's Information")){
                    VStack {
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
                    .navigationTitle("Edit Profile")
                    .toolbar {
                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                            Button {
                                //                            hideKeyboard()
                            } label: {
                                Image(systemName: "keyboard.chevron.compact.down")
                            }
                            Button("Save") {
                                Task {
                                    let success = await petVM.savePet(pet: pet)
                                    if success {
                                        dismiss()
                                    } else {
                                        print("sad")
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }}


//struct PetDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PetDetailView(pet: Pet())
//            .environmentObject(PetViewModel())
//    }
//}
