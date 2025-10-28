//
//  AuthManager.swift
//  ChatDuo
//
//  Created by Amay's Mac on 27/10/25.
//

import Foundation
import Combine     //Since observableObject protocol is a part of Combine framewrok thats why we have to                           import it

class AuthManager: ObservableObject{
    @Published var isLoggedIn: Bool = false
    
    init(){
        checkLoginStatus()
    }
    
    func checkLoginStatus(){
        if let _ = UserDefaults.standard.string(forKey: "authToken") {  //retrieving the stored token
                    isLoggedIn = true
                } else {
                    isLoggedIn = false
                }
            }
    func logout() {
            UserDefaults.standard.removeObject(forKey: "authToken")
            isLoggedIn = false
        }
}


