//
//  ViewController.swift
//  FacBookDemo
//
//  Created by TimMini on 2016/11/11.
//  Copyright © 2016年 TimMini. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FBSDKLoginKit

class ViewController: UIViewController {

    @IBOutlet weak var customLoginButton: UIButton!
    
    @IBAction func customLoginButtonAction(_ sender: Any) {
        customLoginButtonTap(vc: self)
    }
    
    @IBAction func customLogout(_ sender: Any) {
        customLogoutTap()
    }
    @IBAction func getFBNameAction(_ sender: Any) {
        print("getFBName=\(getFBName())")
        
    }
    
    @IBAction func getFBMailAction(_ sender: Any) {
        print("getFBMail=\(getFBMail())")
    }
    
    @IBAction func getFBIdAction(_ sender: Any) {
        print("getFBId=\(getFBId())")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "chat", style: .plain, target: self, action: #selector(joinChat))
        
        defaultLoginButtonTap()
        
        
    }

    func defaultLoginButtonTap() {
        let loginButton = LoginButton(readPermissions: [.publicProfile,.email])
        loginButton.delegate = self
        loginButton.frame = CGRect(x: 16, y: 80, width: UIScreen.main.bounds.width-32, height: 50)
        view.addSubview(loginButton)
        view.backgroundColor = UIColor.white
        navigationItem.title = "Ha!"
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getFBProfile()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
extension ViewController: LoginButtonDelegate {
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "fbid")
    }
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        getFBProfile()
        
    }
    
    func joinChat() {
        if AccessToken.current != nil {
            let layout = UICollectionViewFlowLayout()
//            let chatlog = ChatLogController(collectionViewLayout: layout)
//            navigationController?.pushViewController(chatlog, animated: true)
        }
    }
    
}
