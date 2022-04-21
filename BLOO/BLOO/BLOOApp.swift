//
//  BLOOApp.swift
//  BLOO
//
//  Created by Caroline Umila on 4/18/22.
//

import SwiftUI

@main
struct BLOOApp: App {
    
    var varStore = VarStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(varStore)
        }
    }
}
