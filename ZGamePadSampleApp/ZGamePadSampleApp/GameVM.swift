//  GameVM.swift
//  ZGamePadSampleApp
//  Created by Miguel Gallego on 13/2/25.

import ZGamePadFramework
import SwiftUI

final class GameVM: ObservableObject {
    let gamePad = ZGamepad()
    
    @Published var dpad: CGPoint = .zero    // (±1, ±1) & (0,0) y sus variaciones
    @Published var lStick: CGPoint = .zero
    @Published var rStick: CGPoint = .zero

    
    
    init() {
        gamePad.delegate = self
    }
    
    
}

extension GameVM: MGamepadDelegate {
    func mGamepad_LStick(x: Float, y: Float, player: Int) {
        lStick = CGPointMake(CGFloat(x), CGFloat(y))
    }
    
    func mGamepad_RStick(x: Float, y: Float, player: Int) {
        rStick = CGPointMake(CGFloat(x), CGFloat(y))
    }
    
    func mGamepad_dpadPressed(x: Float, y: Float, player: Int) {
        dpad = CGPointMake(CGFloat(x), CGFloat(y))
    }
    
    func mGamepad_buttonPressed(btnTuple: ZGamePadFramework.BtnTuple) {
        print(btnTuple)
    }
}
