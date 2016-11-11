//
//  FBHelper.swift
//  hachat
//
//  Created by jones wang on 2016/11/1.
//  Copyright © 2016年 J40. All rights reserved.
//

import Foundation
import FacebookCore
import FBSDKLoginKit

func getFBProfile() {
    if AccessToken.current != nil {
        let paramater:[String: Any] = ["fields": "name, email, id,gender,picture.type(large)"]
        
        let graphRequest = GraphRequest(graphPath: "/me", parameters: paramater, accessToken: AccessToken.current, httpMethod: .GET, apiVersion: GraphAPIVersion.defaultVersion)
        graphRequest.start({ (httpResponse, result) in
            
            switch result{
            case .success(let response):
                let data = response.dictionaryValue
                print(data)
                UserDefaults.standard.set(data?["id"], forKey: "fbid")
                UserDefaults.standard.set(data?["name"], forKey: "username")
                UserDefaults.standard.set(data?["email"], forKey: "email")
            
//                let cover = data?["cover"] as! [String: Any]
//                UserDefaults.standard.set(cover["source"]!, forKey: "cover")
                
                
            case .failed(let error):
                print("\(error)")
            }
            
        })
        
    }
}

func customLoginButtonTap(vc:UIViewController) {
    print("customLoginButton")
    let loginFB = FBSDKLoginManager()
    loginFB.logOut()
    loginFB.loginBehavior = FBSDKLoginBehavior.browser
//    let parameters = ["public_profile","email"]

//    let parameters = [UserDefault.PermissionType.publicProfile.rawValue,
//                      UserDefault.PermissionType.email.rawValue]
    let parameters = [PermissionType.publicProfile.rawValue,
                      PermissionType.email.rawValue]
    
    loginFB.logIn(withReadPermissions: parameters, from: vc, handler: { (result, error) -> Void in
        if error != nil {
            print(error?.localizedDescription as Any)
        } else {
            print(result.debugDescription)
            if (result?.isCancelled == true) {
                print("result cancelled")
            } else {
                print("success Get user information.")
                //                    let token = FBSDKAccessToken.current().tokenString
                
                fetchProfile()
            }
        }
    })
    
}
func customLogoutTap() {
    print("1AccessToken=\(AccessToken.current)")
    let loginFB = FBSDKLoginManager()
    loginFB.logOut()
    print("2AccessToken=\(AccessToken.current)")
    
    UserDefaults.standard.removeObject(forKey: "username")
    UserDefaults.standard.removeObject(forKey: "email")
    UserDefaults.standard.removeObject(forKey: "fbid")
    
}
// 獲得FB資料
func fetchProfile(){
    if AccessToken.current != nil {
        let paramater:[String: Any] = ["fields": "name, email, id,gender,picture.type(large)"]
        FBSDKGraphRequest(graphPath: "/me", parameters: paramater)/*height(500).width(500)*/
            .start(completionHandler:  { (connection, result, error) in

                if let result = result as? NSDictionary {

                    
                    UserDefaults.standard.set(result["id"], forKey: "fbid")
                    UserDefaults.standard.set(result["name"] , forKey: "username")
                    UserDefaults.standard.set(result["email"] , forKey: "email")
                    UserDefaults.standard.synchronize()
                    
                }
            })
    }
}

func getFBName() -> String {
    if let username = UserDefaults.standard.string(forKey: "username") {
        return username
    } else {
        return ""
    }
}

func getFBCover() -> String {
    if let cover = UserDefaults.standard.string(forKey: "cover") {
        return cover
    } else {
        return ""
    }
}

func getFBMail() -> String {
    if let email = UserDefaults.standard.string(forKey: "email") {
        return email
    } else {
        return ""
    }
}

func getFBId() -> String {
    if let fbid = UserDefaults.standard.string(forKey: "fbid") {
        return fbid
    } else {
        return ""
    }
}
enum PermissionType: String {
    case publicProfile = "public_profile" //本機 token
    case userFriends = "user_friends"
    case email = "email"
}
