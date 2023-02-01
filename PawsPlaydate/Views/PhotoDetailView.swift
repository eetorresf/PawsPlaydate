//
//  PhotoDetailView.swift
//  PawsPlaydate
//
//  Created by Erika Dey on 1/30/23.
//

import SwiftUI
import PhotosUI
import FirebaseAuth

struct PhotoDetailView: View {

    @State private var uiImageSelected = UIImage()
    @State var changeProfileImage = false
    @State var openCameraRoll = false
    @State var imageSelected = UIImage()
    @State private var showPhotoViewSheet = false
    @State private var selectedPhoto: PhotosPickerItem?
    @ObservedObject var petVM: PetViewModel
//    @Environment(\.dismiss) var dismiss
    
    private let auth = Auth.auth()
    var uuid: String? {
        auth.currentUser?.uid
    }
    
    var body: some View {

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
                                    .frame(width: 120, height: 150)
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
                                        
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                         Task {

                            await petVM.saveImage(image: imageSelected)
                            
                        }

                    })
                    {
                        Text("Add Pet")
                    }
                }
            }

    }
}
