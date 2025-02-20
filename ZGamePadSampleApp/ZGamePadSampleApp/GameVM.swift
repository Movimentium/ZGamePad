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
    @Published var isPressedLStick = false
    @Published var isPressedRStick = false

    
    
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
        switch btnTuple.btnName {
//        case .A:
//            
//        case .B:
//            
//        case .X:
//            
//        case .Y:
//            
//        case .LS:
//            
//        case .RS:
//            
//        case .LT:
//            
//        case .RT:
            
        case .LStick:  isPressedLStick = btnTuple.isPressed
        case .RStick:  isPressedRStick = btnTuple.isPressed
            
//        case .menu:
//            
//        case .home:
//            
//        case .options:
            
        default: break
        }
    }
}
