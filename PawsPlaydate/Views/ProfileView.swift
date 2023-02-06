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
            ViewMyPets()
                .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    NavigationLink("Add A Pet", destination: PetDetailView(pet: petVM.pet))
                        .foregroundColor(Color.blue)
                    }
                    }
                    }
                }
}

//var body: some View {
//    NavigationStack {
//        Text("Welcome \(user.user?.username ?? "")")
//        ViewMyPets()
//            .toolbar {
//            ToolbarItemGroup(placement: .navigationBarTrailing) {
//                NavigationLink("Add A Pet", destination: PetDetailView(pet: petVM.pet))
//                    .foregroundColor(Color.blue)
//                }
//                }
//                }
//            }
//    }
//var body: some View {
//    NavigationStack {
//        Text("Welcome \(user.user?.username ?? "")")
//        ViewMyPets()
//            .toolbar {
//                ToolbarItemGroup(placement: .navigationBarTrailing) {
//                    Button("Add A Pet") {
//                        showSheet.toggle()
//                    }
//                    .sheet(isPresented: $showSheet) {
//                        PetDetailView(pet: petVM.pet)
//                    }
//                }
//            }
//    }
//}
