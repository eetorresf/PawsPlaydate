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
    @State private var showSheet = false
    
    var body: some View {
        NavigationStack {
            Text("Welcome \(user.user?.username ?? "")")
                .font(.system(size: 24, weight: .bold))
            ViewMyPets()
                .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    NavigationLink("Add A Pet", destination: PetDetailView(pet: petVM.pet))
                        .foregroundColor(Color.blue)
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Sign Out") {
                            user.signOut()
                        }
                        .foregroundColor(.blue)
                    }
                    }
                    }
                }
}
