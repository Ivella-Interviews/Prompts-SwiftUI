//
//  Prompts_SwiftUIApp.swift
//  Prompts SwiftUI
//
//  Created by Vishal Dubey on 12/2/22.
//

import SwiftUI

@main
struct Prompts_SwiftUIApp: App {
    
    @StateObject var appNavigator: AppNavigator = AppNavigator()

    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(appNavigator)
        }
    }
}
