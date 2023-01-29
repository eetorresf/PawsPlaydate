//
//  SwiftUIView.swift
//  PawsPlaydate
//
//  Created by Erika Dey on 1/26/23.
//

//import SwiftUI
//import Firebase
//
//class DataManager: ObservableObject {
//    @Published var pets: [Pet] = []
//    
//    init() {
//        fetchPets()
//    }
//    
//    func fetchPets() {
//        pets.removeAll()
//        let db = Firestore.firestore()
//        let ref = db.collection("Pets")
//        ref.getDocuments {snapshot, error in
//            guard error == nil else {
//                print(error!.localizedDescription)
//                return
//            }
//            
//            if let snapshot = snapshot {
//                for document in snapshot.documents {
//                    let data = document.data()
//                    
//                    let id = data["id"] as? String ?? ""
//                    let petName = data["petName"] as? String ?? ""
//                    let breed = data["breed"] as? String ?? ""
//                    let age = data["age"] as? String ?? ""
//                    let fixed = data["fixed"] as? Bool ?? false
//                    let male = data["male"] as? Bool ?? false
//                    let female = data["female"] as? Bool ?? false
//                    let bio = data["bio"] as? String ?? ""
//                    let user = data["user"] as? String ?? ""
//                    
//                    let pet = Pet(id: id, petName: petName, breed: breed, age: age, fixed: fixed, isMale: male, isFemale: female, bio: bio)
//                    self.pets.append(pet)
//                }
//            }
//        }
//    }
//}
