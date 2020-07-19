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
    @State var clickregister = false
    @State var username: String = ""
    @State var password: String = ""
    var body: some View {
        NavigationView {
            ZStack{
                Image("qls").resizable().scaledToFit().position(x:187,y:10)
                VStack {
                    Text("Welcome to the user log in page").foregroundColor(Color.blue).padding(EdgeInsets.init(top: 120, leading: 0, bottom: 10, trailing: 0))
                    HStack {
                        Text("Username").font(.callout).bold().padding(EdgeInsets.init(top: 0, leading: 14, bottom: 0, trailing: 0))
                        TextField("", text: $username).textFieldStyle(RoundedBorderTextFieldStyle())
                    }.padding()

                    HStack {
                        Text("Password ").font(.callout).bold().padding(EdgeInsets.init(top: 0, leading: 14, bottom: 0, trailing: 0))
                        TextField("", text: $password).textFieldStyle(RoundedBorderTextFieldStyle())
                    }.padding()
                    
                    Button(action: {
                        self.showview = true
                    }) {
                        Text("Log in")
                    }.padding(EdgeInsets.init(top: 0, leading: 0, bottom: 30, trailing: 0))
                    Button(action: {
                        self.clickregister = true
                    }) {
                        Text("Register")
                    }.padding(EdgeInsets.init(top: 0, leading: 0, bottom: 30, trailing: 0))
                    NavigationLink(destination: ContentView()
                    .environmentObject(ChatController()), isActive: $showview) {
                        EmptyView()
                    }
                }
            }
        }
        
    }
}

struct register_page: View{
    @State private var offsetposition = CGSize.zero
    var body: some View{
        ZStack{
            Text("Welcome to the registration page").bold().position(x:190,y:90).font(.custom("Didot", size: 30))
            Image("arrow")
                .resizable()
                .scaledToFit()
                .animation(.spring())
                .padding(EdgeInsets.init(top: 30, leading: 14, bottom: 0, trailing: 0)).offset(x: offsetposition.width).gesture(DragGesture().onChanged{ value in self.offsetposition = value.translation}
            .onEnded{ value in self.offsetposition = CGSize.zero}
            )
        }.frame(maxWidth: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        register_page()
    }
}
