//
//  friendlist.swift
//  messagewithswiftui
//
//  Created by Austin  Hu on 7/21/20.
//  Copyright © 2020 Austin  Hu. All rights reserved.
//

import Combine
import SwiftUI

class friendlist: ObservableObject {
    var didchange = PassthroughSubject<Void,Never>()
    @Published var friendList = [
        friend(name: "奥斯丁", picture: "Profile_Picture2"),
        friend(name: "小宝贝", picture: "Profile_Picture1")
    ]
    
    func addfriend(_ newfriend: friend) {
        friendList.append(newfriend)
        didchange.send(())
    }
}
