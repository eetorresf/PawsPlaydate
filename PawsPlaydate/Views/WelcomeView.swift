//
//  WelcomeView.swift
//  PawsPlaydate
//
//  Created by Erika Dey on 2/1/23.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var petVM: PetViewModel
    
    var body: some View {
        TabView {
            ProfileView()
                .tabItem {
                    Image("user")
                    Text("User")
                }
            DisplayMessagesView()
                .tabItem {
                    Image("chat")
                    Text("Chat")
                }
            ViewAllPets()
                .tabItem {
                    Image("paw")
                    Text("Pets")
                }
            MyLikedPetsView()
                .tabItem {
                    Image("heart")
                    Text("Friends")
                }
        }
        
    }
}

struct signOutView: View {
    @EnvironmentObject var user: UserViewModel
    var body: some View {
        NavigationView {
            Button(action: {
                user.signOut()
            }) {
                Text("Sign Out")
            }
        }
    }
}
