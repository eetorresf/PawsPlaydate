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

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct PawsPlaydateApp: App {
    @StateObject var dataManager = DataManager()
//    init() {
//        FirebaseApp.configure()
//    }
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State var petVM = PetViewModel()
    
    var body: some Scene {
        WindowGroup {
            let viewModel = AppViewModel()
            ContentView()
                .environmentObject(viewModel)
                .environmentObject(dataManager)
                .environmentObject(petVM)
        }
    }
}
