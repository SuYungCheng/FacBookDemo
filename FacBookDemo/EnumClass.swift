//
//  EnumClass.swift
//  CallTwo
//
//  Created by 陳彥辰 on 2016/10/29.
//  Copyright © 2016年 RayMini. All rights reserved.
//

import Foundation

class UserDefault {
    /*
     Permission Type
     */
    enum PermissionType: String {
        case publicProfile = "public_profile" //本機 token
        case userFriends = "user_friends"
        case email = "email"
    }
    
}
