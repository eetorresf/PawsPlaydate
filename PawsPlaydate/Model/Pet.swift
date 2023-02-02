//
//  Pet.swift
//  PawsPlaydate
//
//  Created by Erika Dey on 1/26/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift

struct Pet: Identifiable, Codable {
    @DocumentID var id: String?
         
    var petName = ""
    var breed = ""
    var age = ""
    var fixed = false
    var isMale = false
    var isFemale = false
    var bio = ""
    var imageURLString = ""
    var ownerID = ""
        

    var dictionary: [String: Any] {
        return ["petName": petName, "breed": breed, "age": age, "fixed": fixed, "male": isMale, "female": isFemale, "bio": bio, "imageURLString": imageURLString, "ownerID": ownerID]
    }
}
