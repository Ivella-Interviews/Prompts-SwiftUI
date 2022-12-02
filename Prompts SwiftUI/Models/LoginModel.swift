//
//  LoginModel.swift
//  Prompts SwiftUI
//
//  Created by Vishal Dubey on 12/2/22.
//

import Foundation

class LoginModel: ObservableObject {
    
    @Published var enteredGivenName: String
    @Published var enteredUsername: String
    
    @Published var isSubmitting: Bool = false
    @Published var errorMessage: String?
    
    init() {
        self.enteredUsername = ""
        self.enteredGivenName = ""
        self.resetErrorMessage()
    }
    
    func login(completionHandler: @escaping (Error?) -> Void) {
        self.resetErrorMessage()
        
        guard !self.isSubmitting else {
            return
        }
        
        self.isSubmitting = true
        Account.login(username: enteredUsername, givenName: enteredGivenName) { result in
            self.isSubmitting = false
            switch result {
            case .success(let success):
                if success {
                    completionHandler(nil)
                    return
                } else {
                    var error = RuntimeError(message: "Invalid login credentials provided", error: "InvalidCredentials")
                    self.errorMessage = error.message
                    completionHandler(error)
                    return
                }
            case .failure(let failure):
                var error = RuntimeError(message: "Sorry, we are unable to log you in at this time", error: failure)
                self.errorMessage = error.message
                completionHandler(error)
                return
            }
        }
    }
    
    func resetErrorMessage() {
        self.errorMessage = nil
    }
}

struct RuntimeError {
    var message: String
    var error: Error
}

extension RuntimeError: Error { }
