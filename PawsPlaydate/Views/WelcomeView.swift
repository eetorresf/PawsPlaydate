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
//            ChatView()
            DisplayMessagesView()
                .tabItem {
                    Image("chat")
                    Text("Chat")
                }
            ViewAllPets()
                .tabItem {
                    Image("paw")
                    Text("Friends")
                }
//            signOutView()
            MyLikedPetsView()
                .tabItem {
                    Image("exit")
                    Text("Sign Out")
                }
                .foregroundColor(Color.blue)
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
