//
//  UserViewModel.swift
//  PawsPlaydate
//
//  Created by Erika Dey on 1/27/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class UserViewModel: ObservableObject {
    @Published var user: User?
    
    
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    var uuid: String? {
        auth.currentUser?.uid
    }
    var userIsAuthenticated: Bool {
        auth.currentUser != nil
    }
    var userIsAuthenticatedAndSynced: Bool {
        user != nil && userIsAuthenticated
    }
    
    
    //Firebase Auth Functions
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else { return }
            self?.sync()
        }
    }
    
    func signUp(email: String, password: String, username: String, likedPets: [String]) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {return}
            self?.add(User(id: self?.uuid ?? "", username: username, likedPets: likedPets))
                self?.sync()

        }
    }
    
    func signOut() {
        do {
            try auth.signOut()
            self.user = nil
        } catch {
            print("Error signing out user!\(error)")
        }
    }
    
    //Firestore functions for user data
    private func sync() {
        guard userIsAuthenticated else { return }
        db.collection("Users").document(self.uuid!).getDocument { (document, error) in
            guard document != nil, error == nil else {return}
            DispatchQueue.main.async {
            do {
                try self.user = document!.data(as: User.self)
            } catch {
                print("Sync error: \(error)")
            }
        }

        }
    }
    
    private func add(_ user: User) {
        guard userIsAuthenticated else {return}
        do {
            let _ = try db.collection("Users").document(self.uuid!).setData(from: user)
            
        } catch {
            print("error adding user")
        }
    }
    
    private func update() {
        guard userIsAuthenticatedAndSynced else {return}
        do {
            let _ = try db.collection("Users").document(self.uuid!).setData(from: user)
        } catch {
            print("error updating user!")
        }
    }
    
    func updateLikedPets(petId: String) {
        let dataRef = db.collection("Users").document(self.uuid!)
        
        
        dataRef.updateData([
            "likedPets": FieldValue.arrayUnion([petId])
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
}
