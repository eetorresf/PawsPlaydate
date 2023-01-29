//
//  ContentView.swift
//  PawsPlaydate
//
//  Created by Erika Dey on 1/24/23.
//

import PhotosUI
import SwiftUI
import FirebaseAuth
import Combine

//class AppViewModel: ObservableObject {
//
//    let auth = Auth.auth()
//
//    @Published var signedIn = false
//
//    var isSignedIn: Bool {
//        return auth.currentUser != nil
//    }
//
//    func signIn(email: String, password: String) {
//        auth.signIn(withEmail: email,
//                    password: password) { [weak self] result,
//            error in
//            guard result != nil, error == nil else {
//                return
//            }
//            DispatchQueue.main.async {
//                self?.signedIn = true
//            }
//        }
//    }
//
////    func signUp(email: String, password: String) {
////        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
////            guard result != nil, error == nil else {
////                return
////            }
////            DispatchQueue.main.async {
////                self?.signedIn = true
////            }
////        }
////    }
//    func signUp(email: String, password: String) {
//        Auth.auth().createUser(withEmail: email, password: password) { result, error in
//            if let error = error {
//                print("could not create user, \(error.localizedDescription)")
//            } else {
//                print("Successfully created new user")
//                let user = Auth.auth().currentUser
//                                if let user = user {
//                                    let uid = user.uid
//                    DispatchQueue.main.async {
//                        self.signedIn = true
//                    }
//                }
//            }
//        }
//    }
//
//    func signOut() {
//        try? auth.signOut()
//
//        self.signedIn = false
//    }
//
//}

//struct ContentView: View {
//    @EnvironmentObject var viewModel: AppViewModel
//    @State private var fixed = false
//    @State private var isMale = false
//    @State private var isFemale = false
//
//    var body: some View {
//        NavigationView {
//            if viewModel.signedIn {
//                VStack {
//                    NavigationStack {
//                        Text("You are signed in.")
//                            .toolbar {
//                                ToolbarItemGroup(placement: .bottomBar) {
//                                    NavigationLink(destination: PetDetailView(pet: Pet(), uiImage: UIImage(named: "") ?? UIImage(), fixed: $fixed,  isMale: $isMale, isFemale: $isFemale)) {
//                                        Text("Edit Profile")
//                                    }
////                                    NavigationLink(destination: ListView()) {
////                                        Text("View Pets")
////                                    }
//                                    Button("Chat") {
//                                        print("Chat")
//                                    }
//                                    Button(action: {
//                                        viewModel.signOut()
//                                    }, label: {
//                                        Text("Sign Out")
//                                    })
//                                }
//                            }
//                    }
//                }
//            }
//            else {
//                SignInView()
//            }
//        }
//
//        .onAppear {
//            viewModel.signedIn = viewModel.isSignedIn
//        }
//    }
//}

struct ContentView: View {
    @EnvironmentObject var user: UserViewModel
    
    var body: some View {
        NavigationView {
            if user.userIsAuthenticatedAndSynced {
                ProfileView()
            } else {
                AuthenticationView()
            }
        }
    }
}
