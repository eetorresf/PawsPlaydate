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
    @Published var photo = Photo()
//    var image: UIImage
    @Published var pets = [Pet]()

        
    private let db = Firestore.firestore()

    private let auth = Auth.auth()
    var uuid: String? {
        auth.currentUser?.uid
    }
    
    func createPet(petName: String, breed: String, age: String, fixed: Bool, isMale: Bool, isFemale: Bool, bio: String, completion: ((String) -> Void)? = nil) {
        pet = Pet(petName: petName, breed: breed, age: age, fixed: fixed, isMale: isMale, isFemale: isFemale, bio: bio)
            self.addPet(pet, completion: completion)
        
        
    }
    
    
    private func addPet(_ pet: Pet, completion: ((String) -> Void)? = nil) {
        let dataRef = db.collection("Users").document(self.uuid!).collection("pets").document()
        do {
            try? dataRef.setData(from: pet) { err in

                if err != nil {
                    print("Loser :( ")
                }
                completion?(self.uuid!)
            }
        }
    }
//    private func addPet(_ pet: Pet, completion: ((String) -> Void)? = nil) {
////        let dataRef = db.collection("Users").document(self.uuid!)
//        do {
//            // eventually replace self.uuid with petId
////            try db.collection("Pets").document(self.uuid!).setData(from: pet) { err in
//            try db.collection("Pets").document(pet.petID!).collection("pets").document() { err in
//                // replace self.uuid with pet id
//                self.pet.petID = self.uuid!
//                completion?(self.uuid!)
////            try dataRef.updateData(["pets": FieldValue.arrayUnion([pet]) ]) { err in
////                completion?(self.uuid!)
//
//            }
//
//        } catch {
//            print("error adding pet")
//        }
//    }

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
    func fetchPets() {
        db.collection("Pets").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.pets = documents.map{ (queryDocumentSnapshot) -> Pet in
                let data = queryDocumentSnapshot.data()
                
                let petName = data["petName"] as? String ?? ""
                let breed = data["breed"] as? String ?? ""
                let age = data["age"] as? String ?? ""
                let fixed = data["fixed"] as? Bool ?? false
                let isMale = data["isMale"] as? Bool ?? false
                let isFemale = data["isFemale"] as? Bool ?? false
                let bio = data["bio"] as? String ?? ""
                
                return Pet(petName: petName, breed: breed, age: age, fixed: fixed, isMale: isMale, isFemale: isFemale, bio: bio)
                
            }
        }
    }
    

    func saveImage(image: UIImage) async -> Bool {
        guard let petID = pet.petID else {
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


