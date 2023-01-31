//
//  Photo.swift
//  PawsPlaydate
//
//  Created by Erika Dey on 1/26/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Photo: Identifiable, Codable {
    @DocumentID var id: String?
    var imageURLString = ""
    var user = ""
    
    var dictionary: [String: Any] {
        return ["imageURLString": imageURLString, "user": user]
    }
}
