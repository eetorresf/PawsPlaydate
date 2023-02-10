//
//  AuthenticationView.swift
//  PawsPlaydate
//
//  Created by Erika Dey on 1/27/23.
//

import SwiftUI

struct AuthenticationView: View {
    var body: some View {
        SignInView()
        
    }
}

struct SignInView: View {
    @EnvironmentObject var user: UserViewModel
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            Text("Paws Playdate")
                .font(.largeTitle).bold().foregroundColor(Color.white)
                .padding([.top, .bottom], 40)
                .shadow(color: .black, radius: 4, x: 0, y: 4)
            Image("dog")
                .resizable()
                .frame(width: 300, height: 300)
                .padding(.bottom, 50)
            Spacer()
            VStack(alignment: .leading, spacing: 15) {
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color.white)
                SecureField("Password", text: $password)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color.white)
            }
            
            .padding([.leading, .trailing], 25)
            Button(action: {
                guard !email.isEmpty, !password.isEmpty else {
                    return
                }
                user.signIn(email: email, password: password)
            }) {
                Text("Sign In")
                    .font(.headline)
                    .padding()
            }.background(Color.black)
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .padding([.top, .bottom], 20)
            
            NavigationLink("Sign Up!", destination: SignUpView())
                .foregroundColor(Color.white)
        }
        
        .background(
            RadialGradient(gradient: Gradient(colors: [.blue, .purple]), center: .center, startRadius: 100, endRadius: 470).edgesIgnoringSafeArea(.all))
    }
}



struct SignUpView: View {
    @EnvironmentObject var user: UserViewModel
    
    @State private var email = ""
    @State private var password = ""
    @State private var username = ""
    @State private var id = ""
    @State private var likedPets = [""]
    
    var body: some View {
        VStack {
            
            Text("Create an Account")
                .font(.title)
                .foregroundColor(Color.white)
                .padding([.top, .bottom], 40)
            Image("dog")
                .resizable()
                .frame(width: 250, height: 250)
                .padding(.bottom, 50)
            Spacer()
            VStack(alignment: .leading, spacing: 15) {
                
                TextField("Username", text: $username)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color.white)
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color.white)
                SecureField("Password", text: $password)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color.white)
            }
            .padding([.leading, .trailing], 25)
            Button(action: {
                user.signUp(email: email, password: password, username: username)
            }) {
                Text("Sign Up")
                    .font(.headline)
                    .padding()
            }.background(Color.black)
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .padding([.top, .bottom], 20)
        }
        
        .background(
            RadialGradient(gradient: Gradient(colors: [.blue, .purple]), center: .center, startRadius: 100, endRadius: 470).edgesIgnoringSafeArea(.all))
    }
}
