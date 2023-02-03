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
        NavigationStack {
            Text("Welcome \(user.user?.username ?? "")")
            ViewMyPets()
                .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    NavigationLink("Add A Pet", destination: PetDetailView(pet: petVM.pet))
                    }
                    }
                    }
                }
        }
