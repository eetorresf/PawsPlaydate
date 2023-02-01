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
//            NavigationLink("Sign Up!", destination: SignUpView())
        }
    }
}

struct SignInView: View {
    @EnvironmentObject var user: UserViewModel
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            Text("Paws Playdate")
                .font(.largeTitle).foregroundColor(Color.white)
                .padding([.top, .bottom], 40)
                .shadow(color: .black, radius: 4, x: 0, y: 4)
            Image("dog")
                .resizable()
                .frame(width: 250, height: 250)
                .padding(.bottom, 50)
//                .shadow(color: .black, radius: 5, x: 0, y: 5)
            Spacer()
//                .frame(height: 75)
            VStack(alignment: .leading, spacing: 15) {
//                Spacer()
//                    .frame(height: 75)
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
//                        .foregroundColor(Color.white)
//                        .frame(width: 200, height: 50)
//                        .cornerRadius(8)
                        .padding()
                }.background(Color.black)
                .foregroundColor(Color.white)
                .cornerRadius(10)
//                .padding()
//            Spacer()

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
    @State private var pets = [""]
    
    var body: some View {
        VStack {
            
            
//            Text("Welcome to Paws Playdate")
//                .font(.title)
//                .foregroundColor(Color.white)
            Text("Create an Account")
                .font(.title)
                .foregroundColor(Color.white)
                .padding([.top, .bottom], 40)
//            Spacer()
            Image("dog")
                .resizable()
                .frame(width: 250, height: 250)
                .padding(.bottom, 50)
            Spacer()
//                .frame(height: 75)
            VStack(alignment: .leading, spacing: 15) {
//                Spacer()
//                    .frame(height: 75)
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
//                Spacer()
            }
            .padding([.leading, .trailing], 25)
            Button(action: {
                user.signUp(email: email, password: password, username: username)
            }) {
                Text("Sign Up")
            }.background(Color.black)
                .foregroundColor(Color.white)
                .cornerRadius(10)
//                .padding()
        }
        
        .background(
            RadialGradient(gradient: Gradient(colors: [.blue, .purple]), center: .center, startRadius: 100, endRadius: 470).edgesIgnoringSafeArea(.all))
    }
}
