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
            HStack {
                StickView(stickPnt: $vm.lStick,
                          isPressed: $vm.isPressedLStick)
                Spacer()
            }
            HStack {
                DPadView(dpad: $vm.dpad)
                StickView(stickPnt: $vm.rStick,
                          isPressed: $vm.isPressedRStick)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .environmentObject(GameVM())

}
