//
//  Account.swift
//  Prompts SwiftUI
//
//  Created by Vishal Dubey on 12/2/22.
//

import Foundation


class Account: ObservableObject {
    
    static var mine: Account = Account()
    
    @Published var username: String = ""
    @Published var givenName: String = ""
    
    static func login(username: String, givenName: String, completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            Account.mine.username = username.lowercased()
            Account.mine.givenName = givenName.capitalized
            
            print("Successfully logged in user:", username)
            
            completionHandler(.success(true))
            return
        }
    }
    
}
