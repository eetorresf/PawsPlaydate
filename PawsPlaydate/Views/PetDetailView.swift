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
    
    @State private var petName = ""
    @State private var breed = ""
    @State private var age = ""
    @State private var fixed = false
    @State private var isMale = false
    @State private var isFemale = false
    @State private var bio = ""
    @State private var user = ""
    @State private var id = ""
    @Environment(\.dismiss) private var dismiss
    
    @State private var image = UIImage()
    @State private var isTapped = true
    @State private var petId = ""
    
    
    private let auth = Auth.auth()
    var uuid: String? {
        auth.currentUser?.uid
    }
    
    var  body: some View {
        if isTapped {
            NavigationView {
                Form {
                    Section(header: Text("Pet's Information")) {
                        VStack {
                            TextField("Pet's Name", text: $petName)
                            TextField("Breed", text: $breed)
                            TextField("Age", text: $age)
                                .keyboardType(.numberPad)
                                .onReceive(Just(age)){ newValue in
                                    let filtered = newValue.filter {"0123456789" .contains($0)}
                                    if filtered != newValue {
                                        self.age = filtered
                                    }
                                }
                            Section(header: Text("About")){
                                Toggle("Spayed/Neutered", isOn: $fixed)
                                    .toggleStyle(SwitchToggleStyle(tint: .purple))
                            }
                            Section(header: Text("Sex")){
                                VStack(spacing: 20) {
                                    HStack {
                                        SelectButton(isSelected: $isMale, color: .purple, text: "Male")
                                            .onTapGesture {
                                                isMale.toggle()
                                                if isMale {
                                                    isFemale = false
                                                }
                                            }
                                        SelectButton(isSelected: $isFemale, color: .purple, text: "Female")
                                            .onTapGesture {
                                                isFemale.toggle()
                                                if isFemale {
                                                    isMale = false
                                                }
                                            }
                                    }
                                }
                            }
                            .listRowBackground(Color(UIColor.systemGroupedBackground))
                            Section(header: Text("Bio")){
                                TextField("Tell us about your pet", text: $bio, axis: .vertical)
                                    .lineLimit(5...10)
                            }
                        }
                        .navigationTitle("Create Profile")

                        .toolbar {
                            ToolbarItemGroup(placement: .navigationBarTrailing) {
                                Button("Next") {
                                    petVM.createPet(petName: petName, breed: breed, age: age, fixed: fixed, isMale: isMale, isFemale: isFemale, bio: bio) { uuid in
                                        DispatchQueue.main.async {
//                                            petId = uuid
                                            isTapped.toggle()
                                        }
                                    }
                                }
                                }
                            }
                            
                        }
                    }
                }
        } else {
            PhotoDetailView(petVM: petVM)
        }
        }
        
    }
//}


//    @State private var photo = Photo()
//    var uiImage: UIImage
//    @State private var uiImageSelected = UIImage()
//    @State var changeProfileImage = false
//    @State var openCameraRoll = false
//    @State var imageSelected = UIImage()
//    @State private var showPhotoViewSheet = false
//    @State private var selectedPhoto: PhotosPickerItem?

//                                Section(header: Text("Photo")){
//                                    ZStack(alignment: .bottomTrailing){
//                                        Button(action: {
//                                            changeProfileImage = true
//                                            openCameraRoll = true
//                                        }, label: {
//                                            if changeProfileImage {
//                                                Image(uiImage: imageSelected)
//                                                    .resizable()
//                                                    .frame(width: 120, height: 150)
//                                            } else {
//                                                Image("dog")
//                                                    .resizable()
//                                                    .frame(width: 120, height: 120)
//                                                    .background(Color.gray)
//                                            }
//                                        })
//                                        Image(systemName: "plus")
//                                            .frame(width: 30, height: 30)
//                                            .foregroundColor(.purple)
//                                            .background(Color.white)
//                                            .clipShape(Circle())
//                                    }
//                                    .sheet(isPresented: $openCameraRoll) {
//                                        ImagePicker(selectedImage: $imageSelected, sourceType: .photoLibrary)
//                                    }
////                                    .sheet(isPresented: $showPhotoViewSheet) {
////                                        NavigationStack {
////                                            PhotoView(uiImage: uiImageSelected, pet: pet)
////                                        }
////                                    }
//
//                                }
////                Section(header: Text("Photo")) {
////                    PhotosPicker(selection: $selectedPhoto, matching: .images, preferredItemEncoding: .automatic) {
////                        Image("dog")
////                    }
////                    .onChange(of: selectedPhoto) {
////                        newValue in
////                        Task {
////                            do {
////                                if let data = try await newValue?.loadTransferable(type: Data.self) {
////                                    if let uiImage = UIImage(data: data) {
////                                        uiImageSelected = uiImage
////                                        print("Successful!")
////                                        showPhotoViewSheet.toggle()
////                                        dismiss()
////                                    }
////
////                                }
////                            }
////                            catch {
////                                print("Nah")
////                            }
////                        }
////                    }
////                }
// 
