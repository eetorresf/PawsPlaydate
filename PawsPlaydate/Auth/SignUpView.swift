//
//  SignUpView.swift
//  PawsPlaydate
//
//  Created by Erika Dey on 1/26/23.
//

import SwiftUI

//struct SignUpView: View {
//    @State var email = ""
//    @State var password = ""
//    
//    @EnvironmentObject var viewModel: AppViewModel
//    
//    var body: some View {
//        VStack {
//            Image("logo")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 150, height: 150)
//            
//            VStack {
//                TextField("Email Address", text: $email)
//                    .disableAutocorrection(true)
//                    .autocapitalization(.none)
//                    .padding()
//                    .background(Color(.secondarySystemBackground))
//                SecureField("Password", text: $password)
//                    .disableAutocorrection(true)
//                    .autocapitalization(.none)
//                    .padding()
//                    .background(Color(.secondarySystemBackground))
//                
//                Button(action: {
//                    
//                    guard !email.isEmpty, !password.isEmpty else {
//                        return
//                    }
//                    
//                    viewModel.signUp(email: email, password: password)
//                    
//                }, label: {
//                    Text("Create an Account")
//                        .foregroundColor(Color.purple)
//                        .frame(width: 200, height: 50)
//                        .background(Color.white)
//                        .cornerRadius(8)
//                })
//                
//            }
//            .padding()
//            
//            Spacer()
//        }
//        .navigationTitle("Create an Account")
//    }
//}
