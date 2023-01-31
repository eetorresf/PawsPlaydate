//
//  ContentView.swift
//  PawsPlaydate
//
//  Created by Erika Dey on 1/24/23.
//


import SwiftUI



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
