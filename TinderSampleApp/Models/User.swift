//
//  User.swift
//  TinderSampleApp
//
//  Created by 清水世那 on 2021/07/09.
//

import Foundation
import Firebase

class User {
    var email :String
    var name :String
    var createdAt : Timestamp
    
    init(dic: [String:Any]) {
        self.email = dic["email"] as? String ?? ""
        self.name = dic["name"] as? String ?? ""
        self.createdAt = dic["createdAt"] as? Timestamp ?? Timestamp()
    }
}
