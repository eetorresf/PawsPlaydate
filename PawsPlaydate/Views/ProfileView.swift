//
//  ProfileView.swift
//  PawsPlaydate
//
//  Created by Erika Dey on 1/27/23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var user: UserViewModel
    @EnvironmentObject var petVM: PetViewModel
    
    var body: some View {
        VStack {
            NavigationStack {
                
                Text("Successfully logged in \(user.user?.username ?? "")")
                    .toolbar {
                        ToolbarItemGroup(placement: .bottomBar) {
                            NavigationLink(destination: PetDetailView()) {
                                Text("Your Pets")
                            }
                            Button("Chat") {
                                print("Chat")
                            }
                            NavigationLink(destination: ViewMyPets()) {
                                Text("Friends")
                            }
                            Button(action: {
                                user.signOut()
                            }) {
                                Text("Sign Out")
                            }
                        }
                    }
            }
        }
    }
}

