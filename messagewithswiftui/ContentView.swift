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

struct friend:Hashable{
    var name: String
    var picture: String
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


struct chat_list: View {
    @EnvironmentObject var friend_list: friendlist
    @State var clickoption = false
    var body: some View {
        NavigationView{
            List {
                ForEach(friend_list.friendList, id: \.self) { msg in
                   Group {
                    ZStack {
                        Image(msg.picture).resizable().frame(width:55,height:60,alignment: .center)
                            .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 90))
                        Text(msg.name)
                        .frame(alignment:.top)
                        .padding(EdgeInsets.init(top: 0, leading: 50, bottom: 30, trailing: 0))
                        .font(.custom("Didot", size: 20))
                    }
                   }.frame(height:70)
                }
            }
            .overlay(Button(action:
            {self.clickoption = true}) {
                Rectangle().fill(Color(red: 152/255, green: 251/255, blue: 152/255)).frame(width:40,height: 70)
                    .padding(EdgeInsets.init(top: 0, leading: 330, bottom: 0, trailing: 0))
                    .overlay(Text("+")
                        .padding(EdgeInsets.init(top: 0, leading: 334, bottom: 5, trailing: 0))
                        .font(.custom("Arial Black", size: 50))
                        .foregroundColor(Color(red: 210/255, green: 105/255, blue: 30/255)))
            }).navigationBarTitle("")
            .navigationBarHidden(true)
            NavigationLink(destination: add_friend_page(), isActive: $clickoption) {
            EmptyView()
            }
        }
    }
    func settotrue() {
        self.clickoption = true
    }
    
}

struct add_friend_page: View{
    var body: some View {
        List{
            HStack {
                Text("Add friend")
                Text(">>>")
                .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
        }
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
                Image("qls").resizable().frame(width:370,height:300).padding(EdgeInsets.init(top: 0, leading: 0, bottom: 380, trailing: 0))
                VStack {
                    Text("Welcome to the user log in page").foregroundColor(Color.blue).padding(EdgeInsets.init(top: 270, leading: 0, bottom: 0, trailing: 0))
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
                    NavigationLink(destination: chat_list().environmentObject(friendlist()), isActive: $showview) {
                        EmptyView()
                    }
                    NavigationLink(destination: register_page(), isActive: $clickregister) {
                        EmptyView()
                    }
                }
            }/*.navigationBarTitle("")
            .navigationBarHidden(true)*/
        }
        
    }
}

struct register_page: View{
    @State private var offsetposition = CGSize.zero
    @State private var check = CGFloat.zero
    @State private var jump = false
    var body: some View{
        NavigationView {
            ZStack{
                Text("Welcome to the registration page").bold().position(x:190,y:0).font(.custom("Didot", size: 30))
                //arrow image which allows swipe
                Image("arrow")
                    .resizable()
                    .scaledToFit()
                    .animation(.spring())
                    .padding(EdgeInsets.init(top: 0, leading: 14, bottom: 100, trailing: 0)).offset(x: offsetposition.width).gesture(DragGesture()
                        .onChanged{ value in self.offsetposition = value.translation}
                        .onEnded{ value in
                            self.check = self.offsetposition.width
                            self.jump = true
                            self.offsetposition = CGSize.zero
                        }
                )
                NavigationLink(destination: jumped_register_page(), isActive: $jump) {
                    EmptyView()
                }
            }.frame(maxWidth: .infinity)
                .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
    //need to fix later
    func needjump(position:CGFloat) -> AnyView {
        if position > 200 {
            self.jump = true
        }
        return AnyView(EmptyView())
    }
}



//if arrow moved at least 200 pixels, then change jump variable to true and jump to the true registration page
struct jumped_register_page: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var complete = false
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.white)
                .frame(width: 300, height: 400)
            Text("Register Information")
                .padding(EdgeInsets.init(top: 0, leading: 14, bottom: 350, trailing: 0))
                .font(.custom("Didot", size: 20))
                .foregroundColor(Color(red: 47/255, green: 79/255, blue: 79/255))
            Text("Username:")
                .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 260, trailing: 200))
                .font(.custom("Didot", size: 15))
                .foregroundColor(Color(red: 139/255, green: 69/255, blue: 19/255))
            TextField("", text: $username)
                .padding(EdgeInsets.init(top: 0, leading: 15, bottom: 200, trailing: 15))
                .frame(width:300,height:30).textFieldStyle(RoundedBorderTextFieldStyle())
            Text("Password:")
                .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 130, trailing: 200))
                .font(.custom("Didot", size: 15))
                .foregroundColor(Color(red: 139/255, green: 69/255, blue: 19/255))
            TextField("", text: $password)
                .padding(EdgeInsets.init(top: 0, leading: 15, bottom: 70, trailing: 15))
                .frame(width:300,height:30).textFieldStyle(RoundedBorderTextFieldStyle())
            Text("Confirm Password:")
                .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 140))
                .font(.custom("Didot", size: 15))
                .foregroundColor(Color(red: 139/255, green: 69/255, blue: 19/255))
            TextField("", text: $password)
                .padding(EdgeInsets.init(top: 70, leading: 15, bottom: 0, trailing: 15))
                .frame(width:300,height:30).textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: {
                self.complete = true
            }) {
                Text("Register").frame(maxWidth:150,maxHeight: 40).background(Color.blue).foregroundColor(Color.white).cornerRadius(10)
            }.frame(maxHeight:40)
            .padding(EdgeInsets.init(top: 240, leading: 0, bottom: 0, trailing: 0))
            
            
        }.navigationBarTitle("")
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity,maxHeight: .infinity)
         .background(Color(red: 102/255, green: 205/255, blue: 170/255))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //chat_list().environmentObject(friendlist())
        //add_friend_page()
        AppContentView()
        //ContentView()
        //.environmentObject(ChatController()
    }
}
