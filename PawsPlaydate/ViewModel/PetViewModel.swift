//
//  NewUserModel.swift
//  PawsPlaydate
//
//  Created by Erika Dey on 1/25/23.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth
import UIKit


class PetViewModel: ObservableObject {
    
    @Published var pet = Pet()
//    @Published var pet: Pet?
        
    private let db = Firestore.firestore()

    private let auth = Auth.auth()
    var uuid: String? {
        auth.currentUser?.uid
    }
    
    func createPet(petName: String, breed: String, age: String, fixed: Bool, isMale: Bool, isFemale: Bool, bio: String, user: String) {
        DispatchQueue.main.async {
            self.addPet(Pet(petName: petName, breed: breed, age: age, fixed: fixed, isMale: isMale, isFemale: isFemale, bio: bio, user: self.uuid ?? ""))
        }
    }
    
    
    
    private func addPet(_ pet: Pet) {
        do {
            let _ = try db.collection("Pets").document(self.uuid!).setData(from: pet)
            
        } catch {
            print("error adding pet")
        }
    }
    private func updatePet() {
        do {
            let _ = try db.collection("Pets").document(self.uuid!).setData(from: pet)
        } catch {
            print("error updating pet!")
        }
    }
    private func syncPet() {
        db.collection("Pets").document(self.uuid!).getDocument { (document, error) in
            guard document != nil, error == nil else {return}
            do {
                try self.pet = document!.data(as: Pet.self)
            } catch {
                print("Sync error for Pet: \(error)")
            }
        }
    }
    
//    func savePet(pet: Pet) async -> Bool {
//        let db = Firestore.firestore()
//
//        
//        if let id = pet.id {
//            do {
//                try await db.collection("Pets").document(id).setData(pet.dictionary)
//                print("yay!")
//                return true
//            } catch {
//                print("Error could not update \(error.localizedDescription)")
//                return false
//            }
//        } else {
//            do {
//                try await db.collection("Pets").addDocument(data: pet.dictionary)
////                await saveImage(pet: pet, photo: photo, image: uiImage)
//                print("yay new data!")
//                return true
//            } catch {
//                print("Error could not create \(error.localizedDescription)")
//                return false
//            }
//        }
//        
//    }
    func saveImage(pet: Pet, photo: Photo, image: UIImage) async -> Bool {
        guard let petID = pet.id else {
            print("pet.id == nil")
            return false
        }
        let photoName = UUID().uuidString
        let storage = Storage.storage()
        let storageRef = storage.reference().child("\(petID)/\(photoName).jpeg")
        
        guard let resizedImage = image.jpegData(compressionQuality: 0.2) else {
            print("could not resize")
            return false
        }
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        var imageURLString = ""
        
        do {
            let _ = try await storageRef.putDataAsync(resizedImage, metadata: metadata)
            do {
                let imageURL = try await storageRef.downloadURL()
                imageURLString = "\(imageURL)"
            } catch {
                print("could not get imageURL after saving image")
                return false
            }
        } catch {
            print("erorr uploading")
            return false
        }
        let db = Firestore.firestore()
        let collectionString = "Pets/\(petID)/photos"
        
        do {
            var newPhoto = photo
            newPhoto.imageURLString = imageURLString
            try await db.collection(collectionString).document(photoName).setData(newPhoto.dictionary)
            print("so cool")
            return true
        } catch {
            print("could not updata data in photos")
            return false
        }
    }
}
