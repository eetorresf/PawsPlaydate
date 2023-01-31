//
//  PawsPlaydateApp.swift
//  PawsPlaydate
//
//  Created by Erika Dey on 1/24/23.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth


@main
struct PawsPlaydateApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            let user = UserViewModel()
            let petVM = PetViewModel()
            ContentView()
                .environmentObject(user)
                .environmentObject(petVM)
        }
    }
}
