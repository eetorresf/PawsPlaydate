//
//  AuthenticationView.swift
//  PawsPlaydate
//
//  Created by Erika Dey on 1/27/23.
//

import SwiftUI

struct AuthenticationView: View {
    var body: some View {
        VStack {
            SignInView()
            NavigationLink("Sign Up!", destination: SignUpView())
        }
    }
}

struct SignInView: View {
    @EnvironmentObject var user: UserViewModel
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            Spacer()
            Text("Paws Playdate")
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            Spacer()
            VStack {
                
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                SecureField("Password", text: $password)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                Button(action: {
                    guard !email.isEmpty, !password.isEmpty else {
                        return
                    }
                    user.signIn(email: email, password: password)
                }) {
                    Text("Sign In")
                }
                .foregroundColor(Color.blue)
                .frame(width: 200, height: 50)
                .background(Color.white)
                .cornerRadius(8)
            }
            
        }
    }
}

struct SignUpView: View {
    @EnvironmentObject var user: UserViewModel

    @State private var email = ""
    @State private var password = ""
    @State private var username = ""
    @State private var id = ""
    @State private var pets = [""]
    
    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .disableAutocorrection(true)
            TextField("Email", text: $email)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            SecureField("Password", text: $password)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            Button(action: {
                user.signUp(email: email, password: password, username: username)
            }) {
                Text("Sign Up")
            }
            
        }
    }
}
