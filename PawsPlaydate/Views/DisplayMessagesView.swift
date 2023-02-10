//
//  DisplayMessagesView.swift
//  PawsPlaydate
//
//  Created by Erika Dey on 2/6/23.
//

import SwiftUI

struct DisplayMessagesView: View {
    
    @ObservedObject var messagesVM = DisplayMessagesViewModel()
    @EnvironmentObject var user: UserViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(user.user?.username ?? "")")
                            .font(.system(size: 24, weight: .bold))
                        HStack {
                            Circle()
                                .foregroundColor(.green)
                                .frame(width: 14, height: 14)
                            Text("online")
                                .font(.system(size: 12))
                                .foregroundColor(Color(.lightGray))
                        }
                    }
                    Spacer()
                    Image(systemName: "gear")
                }
                .padding()
                
                ScrollView {
//                    Text("TEST")
                    ForEach(messagesVM.users) { user in
                        VStack {
                            NavigationLink {
                                ChatView()
                            } label: {
                                
                                HStack(spacing: 16) {
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 32))
                                        .padding(8)
                                        .overlay(RoundedRectangle(cornerRadius: 44)
                                            .stroke(Color(.label), lineWidth: 1))
                                    //                                Text("Message row")
                                    VStack(alignment: .leading) {
                                        Text(user.username)
                                            .font(.system(size: 16, weight: .bold))
                                        Text("Message sent to user")
                                            .font(.system(size: 14))
                                            .foregroundColor(Color(.lightGray))
                                    }
                                    
                                    Text("11d")
                                        .font(.system(size: 14, weight: .semibold))
                                }
                                .foregroundColor(.black)
                            }
                            Divider()
                                .padding(.vertical, 8)
                        }.padding(.horizontal)
                    }.padding(.bottom, 50)
                }
            }
            .overlay(
                newMessageButton, alignment: .bottom
)
            .navigationBarHidden(true)
        }
    }
    
    @State var shouldShowNewMessageScreen = false
    
    private var newMessageButton: some View {
        Button {
            shouldShowNewMessageScreen.toggle()
    } label : {
        HStack {
            Spacer()
            Text("New Message")
                .font(.system(size: 16, weight: .bold))
            Spacer()
        }
        .foregroundColor(.white)
        .padding(.vertical)
            .background(Color.blue)
            .cornerRadius(32)
            .padding(.horizontal)
            .shadow(radius: 15)
    }
    .fullScreenCover(isPresented: $shouldShowNewMessageScreen) {
        createNewMessageView()
    }
    }
    
}



struct createNewMessageView: View {
    @ObservedObject var messagesVM = DisplayMessagesViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(messagesVM.users) { user in
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack(spacing: 16) {
                            Image("person.fill")
                                .foregroundColor(.black)
                                .font(.system(size: 32))
                                .padding(8)
                                .overlay(RoundedRectangle(cornerRadius: 44))
                            Text(user.username)
                                .foregroundColor(.black)
                            Spacer()
                        }.padding(.horizontal)
                    }
                    Divider()
                        .padding(.vertical, 8)
                }
            }.navigationTitle("New Message")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Cancel")
                                .foregroundColor(.blue)
                        }
                    }
                }
        }
    }
}
