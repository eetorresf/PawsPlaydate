//
//  DisplayMessagesViewModel.swift
//  PawsPlaydate
//
//  Created by Erika Dey on 2/6/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class DisplayMessagesViewModel: ObservableObject {
    
    @Published var users = [User]()
    @Published var errorMessage = ""
    
    private let db = Firestore.firestore()
    private let auth = Auth.auth()
    var uuid: String? {
        auth.currentUser?.uid
    }
    
    init() {
        fetchAllUsers()
    }
    private func fetchAllUsers() {
        db.collection("Users").getDocuments { documentsSnapshot, error in
            if error == nil {
                if let documentsSnapshot = documentsSnapshot {
                    DispatchQueue.main.async {
                        self.users = documentsSnapshot.documents.map { user in
                            return try! user.data(as: User.self)
                        }
                    }
                }
            }
            else {
                //
            }
        }
    }
    
}
