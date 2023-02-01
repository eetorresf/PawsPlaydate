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
//        Text("Welcome \(user.user?.username ?? "")")
        TabView {
            PetDetailView()
                .tabItem {
                    Image("user")
                    Text("User")
                }
            Text("Chat")
                .tabItem {
                    Image("chat")
                    Text("Chat")
                }
            ViewMyPets()
                .tabItem {
                    Image("paw")
                    Text("Friends")
                }
            signOutView()
                .tabItem {
                    Image("exit")
                    Text("Sign Out")
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

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
