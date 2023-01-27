//
//  ListView.swift
//  PawsPlaydate
//
//  Created by Erika Dey on 1/26/23.
//

import SwiftUI

struct ListView: View {
    @State private var sheetIsPresented = false
    @EnvironmentObject var dataManager: DataManager
    @State private var fixed = false
    @State private var isMale = false
    @State private var isFemale = false
    
    var body: some View {
        NavigationView {
            List(dataManager.pets, id: \.id) { pet in
                
//                Text(pet.breed)
                Text(pet.petName)
            }
            .navigationTitle("Dogs")
            .navigationBarItems(trailing: Button(action: {
                sheetIsPresented.toggle()
            }, label: {
                Image(systemName: "plus")
            }))
            .sheet(isPresented: $sheetIsPresented) {
                NavigationStack{
                    PetDetailView(pet: Pet(), fixed: $fixed,  isMale: $isMale, isFemale: $isFemale)
                }
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    
    static var previews: some View {
        ListView()
    }
}
