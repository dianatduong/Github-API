//
//  APITestApp.swift
//  APITest
//
//  Created by Diana Duong on 8/11/24.
//

import SwiftUI

@main
struct APITestApp: App {
    
    @Bindable var nm = NetworkManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView(nm: nm)
        }
    }
}
