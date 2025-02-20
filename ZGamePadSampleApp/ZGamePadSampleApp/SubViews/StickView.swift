//  StickView.swift
//  ZGamePadSampleApp
//  Created by Miguel Gallego on 20/2/25.

import SwiftUI

struct StickView: View {
    @Binding var stickPnt: CGPoint
    @Binding var isPressed: Bool

    var bgColor: Color = .black
    static var w: CGFloat = 80
    let centro = CGPoint(x: Self.w / 2, y: Self.w / 2)
    
    var body: some View {
        ZStack {
            RadialGradient(colors: [Color.blue.opacity(isPressed ? 1 - 0.33 : 0), Color.clear],
                           center: .center,
                           startRadius: Self.w * 0.3,
                           endRadius: Self.w)
            
            Path { path in
                path.move(to: centro)
                // REVISAR: esto no es totalmente preciso
                let entPnt = CGPoint(x: centro.x + (stickPnt.x * Self.w / 2),
                                     y: centro.y + (stickPnt.y * Self.w / 2) * -1)
                path.addLine(to: entPnt)
            }
            .stroke(Color.red, style: StrokeStyle(lineWidth: 4, lineCap: .round))
            
            Circle()
                .stroke(Color.blue, lineWidth: 8)
        }
        .frame(width: Self.w, height: Self.w)
        .background {
            bgColor
        }
        .clipShape(Circle())
    }
    
}

#Preview {
    StickView(stickPnt: .constant(CGPoint(x: 1, y: 1)), 
              isPressed: .constant(false))
}
