//
//  ContentView.swift
//  PawsPlaydate
//
//  Created by Erika Dey on 1/24/23.
//

import SwiftUI
import FirebaseAuth

class AppViewModel: ObservableObject {
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email,
                    password: password) { [weak self] result,
            error in
            guard result != nil, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    func signOut() {
        try? auth.signOut()
        
        self.signedIn = false
    }
    
}

struct ContentView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView {
            if viewModel.signedIn {
                VStack {
                    Text("You are signed in.")
                    
                    Button(action: {
                        viewModel.signOut()
                    }, label: {
                        Text("Sign Out")
                            .frame(width: 150, height: 50)
                            .background(Color.blue)
                            .foregroundColor(Color.white)
                            .padding()
                    })
                }
            }
            else {
                SignInView()
            }
        }
        .onAppear {
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}


struct SignInView: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack {
            Spacer()
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            
            Spacer()
            
            VStack {
                TextField("Email Address", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                SecureField("Password", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                
                Button(action: {
                    
                    guard !email.isEmpty, !password.isEmpty else {
                        return
                    }
                    
                    viewModel.signIn(email: email, password: password)
                    
                }, label: {
                    Text("Sign In")
                        .foregroundColor(Color.blue)
                        .frame(width: 200, height: 50)
                        .background(Color.white)
                        .cornerRadius(8)
                })
                
                NavigationLink("Create an Account", destination: SignUpView())
                    .padding()
            }
            .padding()
            
            Spacer()
        }
        .navigationTitle("Sign In")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SignUpView: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            
            VStack {
                TextField("Email Address", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                SecureField("Password", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                
                Button(action: {
                    
                    guard !email.isEmpty, !password.isEmpty else {
                        return
                    }
                    
                    viewModel.signUp(email: email, password: password)
                    
                }, label: {
                    Text("Create an Account")
                        .foregroundColor(Color.purple)
                        .frame(width: 200, height: 50)
                        .background(Color.white)
                        .cornerRadius(8)
                })
                
            }
            .padding()
            
            Spacer()
        }
        .navigationTitle("Create an Account")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
//            .preferredColorScheme(.dark)
    }
}

struct ProfileView: View {
    
    @State private var petName = ""
    @State private var breed = ""
    @State private var birthdate = Date()
    @State private var spayedNeutered = false
    
    @State private var isMale = false
    @State private var isFemale = false
//    @State private var showAlert = false
//    @State private var alertText = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Photo")){
                    ZStack{
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "dog.outline")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 150)
//                                .clipShape(Circle())
//                                .font(.system(size: 64))
                                .foregroundColor(.gray)
                                .padding()
                        })
//                        Image(systemName: "plus")
//                            .frame(width: 30, height: 30)
//                            .foregroundColor(.purple)
//                            .background(Color.white)
                    }
                }
                Section(header: Text("Pet's Information")){
                    TextField("Pet Name", text: $petName)
                    TextField("Breed", text: $breed)
                    DatePicker("Birthdate", selection: $birthdate, displayedComponents: .date)
                }
                Section(header: Text("About")){
                    Toggle("Spayed/Neutered", isOn: $spayedNeutered)
                        .toggleStyle(SwitchToggleStyle(tint: .purple))
                    
                    
                }
                VStack(spacing: 20) {
                    Text("Sex")
                    HStack {
                        SelectButton(isSelected: $isMale, color: .purple, text: "Male")
                            .onTapGesture {
                                isMale.toggle()
                                
                                if isMale {
                                    isFemale = false
                                }
                            }
                        SelectButton(isSelected: $isFemale, color: .purple, text: "Female")
                            .onTapGesture {
                                isFemale.toggle()
                                
                                if isFemale {
                                    isMale = false
                                }
                            }
                    }
                }
                .padding()
            }
            .navigationTitle("Edit Profile")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        hideKeyboard()
                    } label: {
                        Image(systemName: "keyboard.chevron.compact.down")
                    }
                    Button("Save", action: saveUser)
                }
            }
        }
        .accentColor(.purple)
    }
    func saveUser() {
        print("User Saved")
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
