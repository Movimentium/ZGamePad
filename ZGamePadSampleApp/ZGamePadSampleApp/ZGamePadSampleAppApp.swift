//
//  ZGamePadSampleAppApp.swift
//  ZGamePadSampleApp
//
//  Created by Miguel Gallego on 19/2/25.
//

import SwiftUI

@main
struct ZGamePadSampleAppApp: App {
    @StateObject var gameVM = GameVM()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(gameVM)
        }
    }
}
