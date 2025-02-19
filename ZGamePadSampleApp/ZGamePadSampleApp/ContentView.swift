//  ContentView.swift
//  ZGamePadSampleApp
//  Created by Miguel Gallego on 19/2/25.

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm: GameVM

    var body: some View {
        VStack {
            Text("dPad").frame(maxWidth: .infinity, alignment: .leading)
            Text("x: \(vm.dpad.x) y: \(vm.dpad.y)").monospaced()
                .frame(maxWidth: .infinity, alignment: .leading)
            DPadView()
                .frame(width: DPadView.w, height: DPadView.w)
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .environmentObject(GameVM())

}
