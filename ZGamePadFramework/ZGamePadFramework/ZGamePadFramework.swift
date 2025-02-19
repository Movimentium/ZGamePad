//  ZGamePadFramework.swift
//  ZGamePadFramework
//  Created by Miguel Gallego on 19/2/25.

import GameController

typealias BtnTuple = (btnName: BtnName, isPressed: Bool, value: Float, player: Int)

enum BtnName {
    case A, B, X, Y  // Right buttons
    case LS, RS      // Shoulder buttons (left/right)
    case LT, RT      // Triggers buttons  (left/right)
    case menu, home, options
}

protocol MGamepadDelegate: AnyObject {
    func mGamepad_LStick(x: Float, y: Float, player: Int)
    func mGamepad_RStick(x: Float, y: Float, player: Int)
    func mGamepad_dpadPressed(x: Float, y: Float, player: Int)
    func mGamepad_buttonPressed(btnTuple: BtnTuple)
}

final class MGamepad {
    weak var delegate: MGamepadDelegate?
    let notifCenter = NotificationCenter.default
    
    init() {
        notifCenter.addObserver(self, selector: #selector(gamepadDidConnect),
                                name: .GCControllerDidConnect, object: nil)
        notifCenter.addObserver(self, selector: #selector(gamepadDidDisconnect),
                                name: .GCControllerDidDisconnect, object: nil)
    }
    
    deinit {
        notifCenter.removeObserver(self, name: .GCControllerDidConnect, object: nil)
        notifCenter.removeObserver(self, name: .GCControllerDidDisconnect, object: nil)
    }
    
    @objc func gamepadDidConnect() {
        print(Self.self, #function)
        var idxPlayer = 0
        for controller in GCController.controllers() {
            if let _ = controller.extendedGamepad, let playerIdx = GCControllerPlayerIndex(rawValue: idxPlayer) {
                controller.playerIndex = playerIdx
                idxPlayer += 1
                setup(controller: controller)
            } else {
                print(Self.self, #function, "Error with idxPlayer: ", idxPlayer)
            }
        }
    }
    
    @objc func gamepadDidDisconnect(notif: Notification) {
        // TODO:
    }
    
    private func setup(controller: GCController) {
        controller.extendedGamepad?.valueChangedHandler = { [weak self]
            (gamepad: GCExtendedGamepad, element: GCControllerElement) in

            self?.handleInputDetected(gamepad, element: element,
                                      player: controller.playerIndex.rawValue)
        }
    }
    
    private func handleInputDetected(_ gamepad: GCExtendedGamepad, element: GCControllerElement, player: Int) {
        print(Self.self, #function)
        var btnTuple: BtnTuple?
        
        switch element {
        case gamepad.leftThumbstick:
            let x = gamepad.leftThumbstick.xAxis.value
            let y = gamepad.leftThumbstick.yAxis.value
            delegate?.mGamepad_LStick(x: x, y: y, player: player)
            
        case gamepad.rightThumbstick:
            let x = gamepad.rightThumbstick.xAxis.value
            let y = gamepad.rightThumbstick.yAxis.value
            delegate?.mGamepad_RStick(x: x, y: y, player: player)
            
        case gamepad.dpad:
            let d = gamepad.dpad
            delegate?.mGamepad_dpadPressed(x: d.xAxis.value, y: d.yAxis.value, player: player)
            
            // Buttons A B X Y
        case gamepad.buttonA:
            btnTuple = (.A, gamepad.buttonA.isPressed, gamepad.buttonA.value, player)
        case gamepad.buttonB:
            btnTuple = (.B, gamepad.buttonA.isPressed, gamepad.buttonA.value, player)
        case gamepad.buttonX:
            btnTuple = (.X, gamepad.buttonA.isPressed, gamepad.buttonA.value, player)
        case gamepad.buttonY:
            btnTuple = (.Y, gamepad.buttonA.isPressed, gamepad.buttonA.value, player)
            
            // Buttons LS RS LT RT
        case gamepad.leftShoulder:
            btnTuple = (.LS, gamepad.leftShoulder.isPressed, gamepad.leftShoulder.value, player)
        case gamepad.rightShoulder:
            btnTuple = (.RS, gamepad.rightShoulder.isPressed, gamepad.rightShoulder.value, player)
        case gamepad.leftTrigger:
            btnTuple = (.LT, gamepad.leftTrigger.isPressed, gamepad.leftTrigger.value, player)
        case gamepad.rightTrigger:
            btnTuple = (.RT, gamepad.rightTrigger.isPressed, gamepad.rightTrigger.value, player)
            
            // Buttons menu home options
        case gamepad.buttonMenu:
            btnTuple = (.menu, gamepad.buttonMenu.isPressed, gamepad.buttonMenu.value, player)
        case gamepad.buttonHome:
            btnTuple = (.home, gamepad.buttonHome!.isPressed, gamepad.buttonHome!.value, player)
        case gamepad.buttonOptions:
            btnTuple = (.options, gamepad.buttonOptions!.isPressed, gamepad.buttonOptions!.value, player)
        default: break
        }
        if let btnTuple {
            delegate?.mGamepad_buttonPressed(btnTuple: btnTuple)
        }
    }
    
    
}
