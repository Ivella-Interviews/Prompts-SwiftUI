//
//  LoginView.swift
//  Prompts SwiftUI
//
//  Created by Vishal Dubey on 12/2/22.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var navigator: AppNavigator
    @StateObject var loginModel: LoginModel = LoginModel()
    
    var isButtonEnabled: Bool {
        return !loginModel.enteredGivenName.isEmpty && !loginModel.enteredUsername.isEmpty
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                
                Text("Hi there. What's your name?")
                    .font(.system(size: 32, weight: .bold))
                
                    .padding(.top, 64)
                
                TextField("John Doe", text: $loginModel.enteredGivenName)
                    .textFieldStyle(PlainTextFieldStyle())
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 16, weight: .regular))
                    .padding(.vertical, 12)
                    .overlay(VStack{Divider().offset(x: 0, y: 15)})
                    .padding(.top, 40)
                
                TextField("john_doe", text: $loginModel.enteredUsername)
                    .textFieldStyle(PlainTextFieldStyle())
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 16, weight: .regular))
                    .padding(.vertical, 12)
                    .overlay(VStack{Divider().offset(x: 0, y: 15)})
                    .padding(.top, 24)
                
                if let errorMessage = loginModel.errorMessage {
                    HStack {
                        Spacer()
                        Text(errorMessage)
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding(.top, 24)
                        Spacer()
                    }
                }
                
                Spacer()
                
                LoginButton
                    .padding(.bottom, 16)
                
                NavigationLink(destination: QuestionsPage(), isActive: $navigator.navigatePastLoginScreen) {
                    EmptyView()
                }
            }
            .padding(.horizontal, 24)
        }
        .navigationViewStyle(.stack)
    }
    
    @ViewBuilder
    var LoginButton: some View {
        Button(action: {
            loginModel.login { error in
                if error == nil {
                    navigator.navigatePastLoginScreen = true
                }
            }
        }) {
            ZStack {
                HStack(alignment: .center, spacing: 0) {
                    Spacer()
                }
                .padding(.vertical, 16)
                .frame(height: 50)
                .background(RoundedRectangle(cornerRadius: 16).strokeBorder(isButtonEnabled ? .blue : .gray, lineWidth: 3))
                
                Group {
                    if loginModel.isSubmitting {
                        ProgressView()
                            .progressViewStyle(.circular)
                    } else {
                        Text("Continue")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(isButtonEnabled ? .blue : .gray)
                    }
                }
            }
            .frame(height: 50)
        }
        .disabled(!isButtonEnabled)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
