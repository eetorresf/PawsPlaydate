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
    @Published var pets = [Pet]()
    @Published var retrievedImages = [UIImage]()
    
    private let db = Firestore.firestore()
    
    private let auth = Auth.auth()
    var uuid: String? {
        auth.currentUser?.uid
    }


    func createPet(petName: String, breed: String, age: String, fixed: Bool, isMale: Bool, isFemale: Bool, bio: String, imageURLString: String, completion: ((String) -> Void)? = nil) {
        pet = Pet(petName: petName, breed: breed, age: age, fixed: fixed, isMale: isMale, isFemale: isFemale, bio: bio, imageURLString: imageURLString, ownerID: uuid!)
            self.addPet(pet, completion: completion)
        
        
    }
    
    
    private func addPet(_ pet: Pet, completion: ((String) -> Void)? = nil) {
        let dataRef = db.collection("Users").document(self.uuid!).collection("pets").document()
        do {
            try? dataRef.setData(from: pet) { err in

                if err != nil {
                    print("Loser :( ")
                }
                dataRef.getDocument { documentSnapshot, error in
                    do {
                        
                        self.pet = try! documentSnapshot!.data(as: Pet.self)
                    }
                    completion?(dataRef.documentID)
                }
            }
        }
    }

    private func updateImageURL(imageURLString: String) {
        let dataRef = db.collection("Users").document(self.uuid!).collection("pets").document(pet.id!)
        
        
        dataRef.updateData([
            "imageURLString": imageURLString
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    private func syncPet() {
        db.collection("Users").document(self.uuid!).getDocument { (document, error) in
            guard document != nil, error == nil else {return}
            do {
                self.pet = try document!.data(as: Pet.self)
            } catch {
                print("Sync error for Pet: \(error)")
            }
        }
    }

    func fetchAllPets() {

//        let documentid = Auth.auth().currentUser?.uid
        db.collectionGroup("Users").whereField("ownerID", isNotEqualTo: self.uuid!).getDocuments { snapshot, err in
                if  err == nil {
                    if let snapshot = snapshot {
                        DispatchQueue.main.async {
                            
                            self.pets = snapshot.documents.map { pet in
                                return Pet(id: pet.documentID, petName: pet["petName"] as? String ?? "", breed: pet["breed"] as? String ?? "", age: pet["age"] as? String ?? "", fixed: pet["fixed"] as? Bool ?? false, isMale: pet["isMale"] as? Bool ?? false, isFemale: pet["isFemale"] as? Bool ?? false, bio: pet["bio"] as? String ?? "", imageURLString: pet["imageURLString"] as? String ?? "", ownerID: pet["ownerID"] as? String ?? "")
                            }
                        }
                    }
                }
                else {
                    print("Unable to fetch all pets.")
                }
            }
        
    }

    
    func fetchMyPets() {
        db.collection("Users").document(self.uuid!).collection("pets").getDocuments { snapshot, err in
            if  err == nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                            
                        self.pets = snapshot.documents.map { pet in
                            return Pet(id: pet.documentID, petName: pet["petName"] as? String ?? "", breed: pet["breed"] as? String ?? "", age: pet["age"] as? String ?? "", fixed: pet["fixed"] as? Bool ?? false, isMale: pet["isMale"] as? Bool ?? false, isFemale: pet["isFemale"] as? Bool ?? false, bio: pet["bio"] as? String ?? "", imageURLString: pet["imageURLString"] as? String ?? "", ownerID: pet["ownerID"] as? String ?? "")
                    }
                    }
                }
            }
            else {
                //
            }
        }
    }
    

    func saveImage(image: UIImage) async -> Bool {
        let auth = Auth.auth()
        var uuid: String? {
            auth.currentUser?.uid
        }
        let photoName = UUID().uuidString
        let storage = Storage.storage()
        let storageRef = storage.reference().child("\(pet.id!)/\(photoName).jpeg")


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
        let collectionString = "Users/\(self.uuid!)/pets/\(pet.id!)/photos"

        do {
            var newPet = pet
            newPet.imageURLString = imageURLString
            try await db.collection(collectionString).document(photoName).setData(newPet.dictionary)
            updateImageURL(imageURLString: imageURLString)
            print("so cool")
            return true
        } catch {
            print("could not updata data in photos")
            return false
        }
    }
    
//    func retrieveImage() {
//         //Get data from db
//        let db = Firestore.firestore()
//
//        db.collection("photos").getDocuments { snapshot, error in
//            if error == nil && snapshot != nil {
//                var paths = [String]()
//                //loop through all returned docs
//                for doc in snapshot!.documents {
//                    //extract file path
//                    paths.append(doc["imageURL"] as! String)
//                }
//                //loop through each file and fetch data from storage
//                for path in paths {
//                    //Get a reference to storage
//                    let storageRef = Storage.storage().reference()
//                    let fileRef = storageRef.child(path)
//                    //specify the path
//                    fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
//                        if error == nil && data != nil {
//                            if let image = UIImage(data: data!) {
//
//                                DispatchQueue.main.async {
//
//                                    retrievedImages.append(image)
//                                }
//                            }
//                        }
//                    }
//                    //retrive the data
//                }
//            }
//        }
//        //Get data from storage for image reference
//
//        //Display images
//    }
}

