//
//  ContentView.swift
//  messagewithswiftui
//
//  Created by Austin  Hu on 7/9/20.
//  Copyright © 2020 Austin  Hu. All rights reserved.
//

import SwiftUI
struct chatmessage:Hashable{
    var message:String
    var avatar:String
    var color: Color
}

struct ContentView: View {
    @State var composedMessage: String = ""
    @EnvironmentObject var chatController: ChatController
    var body: some View {
        VStack {
            List {
                ForEach(chatController.message, id: \.self) { msg in
                   Group {
                      Text(msg.message)
                         .bold()
                         .foregroundColor(Color.white)
                         .padding(10)
                         .background(msg.color)
                         .cornerRadius(10)
                   }
                }
            }
            HStack {
                // this textField generates the value for the composedMessage @State var
                TextField("Message...", text: $composedMessage).frame(minHeight: CGFloat(30))
                // the button triggers the sendMessage() function written in the end of current View
                Button(action: sendMessage) {
                    Text("Send")
                }
            }.frame(minHeight: CGFloat(50)).padding()
        }
    }
    func sendMessage() {
        chatController.sendMessage(chatmessage(message: composedMessage, avatar: "C", color: .green))
        composedMessage = ""
    }
}

struct AppContentView: View {

    @State var signInSuccess = false
    @State var showview = false
    @State var username: String = ""
    @State var password: String = ""
    var body: some View {
        NavigationView {
            ZStack{
                Image("qls").position(x:180,y:120)
                VStack {
                    Text("Welcome to the user log in page").foregroundColor(Color.blue)
                    HStack {
                        Text("Username:")
                        TextField("", text: $username)
                    }.padding()

                    HStack {
                        Text("Password:")
                        TextField("", text: $password)
                    }.padding()
                    
                    Button(action: {
                        self.showview = true
                    }) {
                        Text("sign in")
                    }
                    NavigationLink(destination: ContentView()
                    .environmentObject(ChatController()), isActive: $showview) {
                        EmptyView()
                    }
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppContentView()
    }
}
