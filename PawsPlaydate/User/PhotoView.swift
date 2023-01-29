//
//  PhotoView.swift
//  PawsPlaydate
//
//  Created by Erika Dey on 1/27/23.
//

import SwiftUI

struct PhotoView: View {
    @State private var photo = Photo()
    var uiImage: UIImage
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var petVM: PetViewModel
    var pet: Pet
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 350)
                
                Spacer()
                
                
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .automatic) {
                    Button("Save") {
                        Task {
                            let success = await petVM.saveImage(pet: pet, photo: photo, image: uiImage)
                            if success {
                                dismiss()
                            }
                        }
                    }
                }
            }
        }
        
    }
}

//struct PhotoView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoView(uiImage: UIImage(named: "hakai") ?? UIImage(), pet: Pet())
//            .environmentObject(PetViewModel())
//    }
//}
