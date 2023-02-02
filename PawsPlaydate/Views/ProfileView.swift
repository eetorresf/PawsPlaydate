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
//                        .foregroundColor(Color.white)
                    }
                    }
                    }
                }
        }




//        VStack {
//            NavigationStack {
//
//                Text("Welcome \(user.user?.username ?? "")")
//                    .bold()
//                    .font(.largeTitle)
//                    .frame(width: 100, height: 100, alignment: .leading)
//                    .toolbar {
//                        ToolbarItemGroup(placement: .bottomBar) {
//                            NavigationLink(destination: PetDetailView()) {
////                                Text("Your Pets")
//                                Image("user")
//                            }
//                            Button(action: {
//                                print("chat")
//                            }) {
////                                Text("Sign Out")
//                                Image("chat")
//                            }
//                            NavigationLink(destination: ViewMyPets()) {
////                                Text("Friends")
//                                Image("paw")
//                            }
//                            Button(action: {
//                                user.signOut()
//                            }) {
////                                Text("Sign Out")
//                                Image("exit")
//                            }
//                        }
//                    }
//            }
//        }
