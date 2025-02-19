//  DPadView.swift
//  ZGamePadSampleApp
//  Created by Miguel Gallego on 19/2/25.

import SwiftUI

struct DPadView: View {
    @EnvironmentObject var vm: GameVM

    static let w: CGFloat = 90
    private let a = 0.75
    
    var body: some View {
        let top = vm.dpad.y == 1 ? 1 : a
        let rig = vm.dpad.x == 1 ? 1 : a
        let lef = vm.dpad.x == -1 ? 1 : a
        let bot = vm.dpad.y == -1 ? 1 : a
        
        ZStack {
            Color.black
            Grid(alignment: .center, horizontalSpacing: 1, verticalSpacing: 1) {
                GridRow {
                    Color(.green.withAlphaComponent(top == 1 && lef == 1 ? 1 : a))
                    Color(.green.withAlphaComponent(top))
                    Color(.green.withAlphaComponent(top == 1 && rig == 1 ? 1 : a))
                }
                GridRow {
                    Color(.green.withAlphaComponent(lef))
                    Color(.green.withAlphaComponent(a))
                    Color(.green.withAlphaComponent(rig))
                }
                GridRow {
                    Color(.green.withAlphaComponent(bot == 1 && lef == 1 ? 1 : a))
                    Color(.green.withAlphaComponent(bot))
                    Color(.green.withAlphaComponent(bot == 1 && rig == 1 ? 1 : a))
                }
            }
            .frame(width: Self.w, height: Self.w)
            .clipShape(RoundedRectangle(cornerRadius: Self.w / 2.5) )
        }
    }

}

#Preview {
    DPadView()
        .environmentObject(GameVM())
}
